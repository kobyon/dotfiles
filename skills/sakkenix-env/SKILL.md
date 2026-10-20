---
name: sakkenix-env
description: Scaffold a new Sakkenix development environment — a container built FROM ghcr.io/sakkenix-base that bundles the user's git repos, language runtimes, libraries, linters and tooling. Use when user says things like "I need a new environment for development", "create a puppet environment", "set up an env with these repos and ruby dev kits", or asks for a child-container on top of the Sakkenix base image. The agent starts in an empty directory and generates Dockerfile, docker-compose.yaml, justfile and repos.txt from the specification in the prompt.
---

# Sakkenix Environment Scaffolding

## What an "environment" is

An environment is a **directory** containing a self-contained container definition that inherits from the Sakkenix base image. It bundles:

- The **git repos** user lists (cloned into the container's `projects` dir by the base image's bootstrap)
- **Language runtimes & dev kits** (Ruby, Python, Rust, Go, Node, ...)
- **Libraries and gems/packages** the work needs
- **Linters, formatters, test runners** and other CLI tooling

It is **local-only**: built and run with `docker compose`, never pushed to a registry.

## Base image facts (do not re-derive, these are current)

`ghcr.io/sakkenix-base` (source: `~/projects/dotfiles`) is Arch Linux `base-devel` with:

| Fact | Value |
| --- | --- |
| Packages preinstalled | zsh, zsh-completions, git, rust, openssh, curl, jq, python, docker, sudo |
| Build args | `USERNAME` (default `ctrl`), `USER_UID` (1000), `USER_GID` (1000) |
| Default user | `USER $USERNAME` (non-root), NOPASSWD sudo |
| Working dir | `/home/$USERNAME` |
| Shell | `/usr/bin/zsh` |
| Entrypoint | `/usr/local/bin/sakkenix-entrypoint` → runs `sakkenix-bootstrap`, then `exec "$@"` |
| Image build does | Installs `paru` (AUR helper) once while building the image |
| Bootstrap does | Aligns `docker` group GID to host `docker.sock`; **clones repos from `/usr/local/share/sakkenix/repos.txt` if present** |
| AUR | Available via `paru`, **must run as non-root** (makepkg refuses root) |
| Projects dir | `/home/$USERNAME/projects`, created and chowned in the image |
| Repos mount point | `/usr/local/share/sakkenix/` — child-containers mount their `repos.txt` here |

## Step 1 — Gather the specification

Extract these from user's prompt. Ask only for what is genuinely missing:

1. **Environment name** — defaults to the current directory name (`basename "$PWD"`).
2. **Repos** — list of git URLs. Note which branch, and whether SSH or HTTPS.
3. **Languages / dev kits** — e.g. "ruby development kits", "python 3.12", "go".
4. **Libraries & tools** — gems, pip packages, linters, formatters, test runners.
5. **Ports / services** — anything that must be reachable (puppetserver 8140, etc.).

If the prompt is thin (e.g. just "a puppet dev environment"), scaffold with sensible defaults for that domain and tell user what you assumed. Do not stall on questions.

## Step 2 — Naming convention

Derive every name from the **directory name**, so the environment is relocatable. Docker Compose sets `COMPOSE_PROJECT_NAME` to the directory name by default — use it rather than hardcoding:

| Resource | Name |
| --- | --- |
| Image | `${COMPOSE_PROJECT_NAME}:latest` |
| Container | `${COMPOSE_PROJECT_NAME}` |
| Projects volume | `${COMPOSE_PROJECT_NAME}` |
| Network | `${COMPOSE_PROJECT_NAME}` |

## Step 3 — Generate the files

Target layout (created in the current, empty directory):

```
<env-dir>/
├── Dockerfile
├── docker-compose.yaml
├── justfile
├── repos.txt            # one git URL per line, read by base bootstrap
├── .env.example         # USERNAME/USER_UID/USER_GID
└── .gitignore
```

**No entrypoint or bootstrap script** — the base image handles repo cloning and runtime setup. Only add custom entrypoint/bootstrap when user explicitly asks to override base behavior.

### `Dockerfile`

```dockerfile
FROM ghcr.io/sakkenix-base:latest

# ARGs do NOT cross the FROM boundary — redeclare to use $USERNAME here
ARG USERNAME=ctrl

USER root

# System packages. Verify names exist before committing to them:
#   docker run --rm ghcr.io/sakkenix-base:latest pacman -Ss <name>
RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm \
      ruby \
      ruby-bundler \
 && pacman -Scc --noconfirm

# Env-specific tooling that is NOT a pacman package (gems, pip, cargo)
USER $USERNAME
RUN gem install --user-install --no-document \
      puppet puppet-strings metadata-json-lint \
      voxpupuli-puppet-lint-plugins voxpupuli-test \
      rake rspec-puppet puppetlabs_spec_helper
```

That's it. No ENTRYPOINT, no CMD — inherited from base. No COPY of scripts — the base bootstrap reads `repos.txt` from the mount point.

### `docker-compose.yaml`

```yaml
services:
  env:
    build:
      context: .
      args:
        USERNAME: ${USERNAME:-ctrl}
        USER_UID: ${USER_UID:-1000}
        USER_GID: ${USER_GID:-1000}
    image: ${COMPOSE_PROJECT_NAME:-env}:latest
    container_name: ${COMPOSE_PROJECT_NAME:-env}
    stdin_open: true
    tty: true
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock        # DooD
      - ${SSH_AUTH_SOCK}:/run/ssh-agent                  # SSH agent forwarding
      - ${XDG_CONFIG_HOME:-$HOME/.config}/git:/home/${USERNAME:-ctrl}/.config/git:ro
      - ${COMPOSE_PROJECT_NAME:-env}:/home/${USERNAME:-ctrl}/projects
      - ./repos.txt:/usr/local/share/sakkenix/repos.txt:ro  # repos for base bootstrap
    environment:
      - SSH_AUTH_SOCK=/run/ssh-agent
      - USERNAME=${USERNAME:-ctrl}
    networks:
      - default
    # Add ports only if the environment exposes services:
    # ports:
    #   - "8140:8140"

volumes:
  ${COMPOSE_PROJECT_NAME:-env}:
    name: ${COMPOSE_PROJECT_NAME:-env}

networks:
  default:
    name: ${COMPOSE_PROJECT_NAME:-env}
```

The key line: `./repos.txt:/usr/local/share/sakkenix/repos.txt:ro` — this mounts the env's repo list into the container where the base bootstrap expects it.

### `repos.txt`

```
# One git URL per line. Blank lines and # comments are ignored.
git@github.com:voxpupuli/puppet-archive.git
```

### `justfile`

```just
COMPOSE := "docker compose"

build:
    {{COMPOSE}} build

up:
    {{COMPOSE}} up -d

down:
    {{COMPOSE}} down

shell *ARGS:
    {{COMPOSE}} exec env zsh {{ARGS}}

logs:
    {{COMPOSE}} logs -f

ssh-check:
    {{COMPOSE}} exec env ssh-add -l

repos:
    # Re-run the base bootstrap to clone/update repos
    {{COMPOSE}} exec env /usr/local/bin/sakkenix-bootstrap

clean:
    {{COMPOSE}} down -v --remove-orphans
```

### `.env.example`

```
USERNAME=ctrl
USER_UID=1000
USER_GID=1000
```

Populate `.env` with the real host values (`id -u`, `id -g`) and gitignore it.

## Step 4 — Domain notes

### Verifying package names

Never assume an Arch package exists. Check before writing it into the Dockerfile:

```bash
docker run --rm ghcr.io/sakkenix-base:latest pacman -Ss <name>
```

For AUR: `docker run --rm ghcr.io/sakkenix-base:latest paru -Ss <name>` (requires an image built with `paru`).

## Step 5 — Verify before reporting done

Do not claim the environment works without running it:

```bash
docker compose build                 # image builds clean
docker compose up -d                 # container starts
docker compose exec env whoami       # correct user
docker compose exec env ls projects  # repos cloned by base bootstrap
docker compose exec env ssh-add -l   # SSH agent forwarded
docker compose exec env docker ps    # DooD works
docker compose exec env <tool> --version   # each requested tool present
```

Report actual output. If a step fails, say so and show the error.

## Pitfalls

- **`ARG` does not survive `FROM`.** Redeclare `ARG USERNAME=ctrl` in the child Dockerfile or `$USERNAME` expands to empty and paths silently break.
- **Overriding `ENTRYPOINT` drops the base bootstrap.** Only do it when explicitly requested, and always chain `sakkenix-bootstrap` first, or docker-group GID alignment and repo cloning stop happening.
- **Named volumes are seeded once.** Anything baked into `/home/$USERNAME/projects` at build time is copied into the volume on first creation only; later rebuilds will not update it. The base bootstrap clones at runtime instead.
- **`paru`/`makepkg` refuse root.** AUR installs must happen as `$USERNAME`.
- **`groupmod`, not `groupadd`.** Arch's `docker` package already creates the `docker` group; the base bootstrap re-GIDs it at runtime. Don't duplicate that logic.
- **SSH clones need the agent.** `${SSH_AUTH_SOCK}` must be set on the host and exported before `docker compose up`, otherwise `git@...` clones fail at bootstrap. For HTTPS repos, credentials must be available in the container.
- **Volume paths are host-relative.** Bind mounts resolve against the Docker host, not the container.

## Related

- Base image source: `~/projects/dotfiles` (Dockerfile, bootstrap, entrypoint, justfile)
- Reference compose: `~/projects/dotfiles/examples/docker-compose.yaml`
- Base architecture decisions: project memory `project/base-container-architecture.md`
