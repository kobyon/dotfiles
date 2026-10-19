# Sakkenix - Base Container Image

An Arch Linux base image for specialized development containers. Provides a consistent foundation with essential DevOps tools, Docker-outside-Docker (DooD) support, and AUR access.

## Purpose

This is a **base image** designed to be extended by sub-containers for specialized environments (Puppet, Ansible, development, etc.). It is pushed to a container registry and inherited via `FROM sakkenix-base:latest`.

## What's Included

- **Arch Linux** with essential packages: zsh, git, rust, openssh, curl, jq, python, docker, sudo
- **Configurable user** with sudo access (USERNAME, UID, GID as build args)
- **Docker CLI** with docker group for DooD (Docker-outside-Docker)
- **AUR support** via `paru`
- **Dotfiles structure** at `/home/$USERNAME/`

## Building

```bash
docker build \
  --build-arg USERNAME=ctrl \
  --build-arg USER_UID=1000 \
  --build-arg USER_GID=1000 \
  -t sakkenix-base:latest .
```

### Build Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `USERNAME` | `ctrl` | Username inside container |
| `USER_UID` | `1000` | User UID (should match host user) |
| `USER_GID` | `1000` | User GID (should match host user) |

**Note:** Docker group GID is automatically adjusted at runtime to match the host's `docker.sock`, so no build-time configuration is needed for DooD.

## Creating Sub-Containers

Sub-containers inherit from this base and add specialized tooling:

```dockerfile
FROM sakkenix-base:latest

# Install specialized packages
RUN sudo pacman -S --noconfirm puppet ansible

# Add custom entrypoint logic
COPY entrypoint /usr/local/bin/custom-entrypoint
ENTRYPOINT ["/usr/local/bin/custom-entrypoint"]
```

### Example: Puppet Agent Container

```dockerfile
FROM sakkenix-base:latest

RUN sudo pacman -S --noconfirm puppet

# Clone puppet repo on first boot
COPY entrypoint /usr/local/bin/puppet-entrypoint
ENTRYPOINT ["/usr/local/bin/puppet-entrypoint"]
```

## Running Containers

When running containers from this base image, you'll typically want to:

### Docker Socket (DooD)
```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock sakkenix-base:latest
```

### SSH Agent Forwarding
```bash
# Create stable symlink on host
ln -sf $SSH_AUTH_SOCK /tmp/ssh-agent-stable

# Mount socket in container
docker run -v /tmp/ssh-agent-stable:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent sakkenix-base:latest
```

### User Mapping
```bash
# Match container user to host user
docker run --user $(id -u):$(id -g) sakkenix-base:latest
```

## Examples

See the `examples/` directory for:
- `docker-compose.yml` - Example orchestration with SSH agent and Docker socket
- `setup.sh` - Helper script to detect host configuration

## File Structure

```
dotfiles/
├── Dockerfile              # Base image definition
├── bootstrap               # AUR package installation (runs as user)
├── entrypoint              # Container entrypoint
├── examples/               # Example configurations
│   ├── docker-compose.yml
│   └── setup.sh
└── home/                   # Dotfiles copied to user's home
    ├── .config/
    │   ├── shell/         # Shell configs (zsh, bash)
    │   ├── git/           # Git config
    │   ├── nvim/          # Neovim config
    │   └── ...
    ├── .ssh/              # SSH public keys and configs
    └── projects/          # Workspace files
```

## Philosophy

The goal is to abstract the underlying OS into a well-tested base image that:
- Provides a consistent Arch environment across all sub-containers
- Supports Docker-outside-Docker for sibling container management
- Keeps dotfiles git-synced and version-controlled
- Allows specialized sub-containers to inherit common tooling
