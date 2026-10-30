# The dotfiles repo

- Checkout: `~/projects/dotfiles` (remote `git@github.com:kobyon/dotfiles.git`, private).
- Paths in the repo mirror `$HOME`: `~/.config/niri/config.kdl` ↔ `<repo>/.config/niri/config.kdl`.
- `$HOME` itself is also a work tree of a bare repo at `~/.local/share/dotfiles/git`; the `.justfile` recipe `dot-pull` pulls it (`git --git-dir=~/.local/share/dotfiles/git --work-tree=$HOME pull --rebase --autostash`). Deploying a branch there drops files straight into `$HOME`.

## Ignore-everything rule

`.gitignore` starts with `*` and only whitelists a few paths. So:

- Stage files explicitly with `git add -f <path>`. Already-tracked files update with a plain `git add <path>`.
- Never `git add -A`, `git add .` or `git add -f <directory>`: the mirrored tree contains secrets such as `~/.claude/.credentials.json` and `~/.ssh` keys.
- Check `git status -s` before committing; it should list only the files you meant.

## Syncing a change from $HOME

```bash
cd ~/projects/dotfiles
cp ~/.config/niri/config.kdl .config/niri/config.kdl
git add -f .config/niri/config.kdl
```

Diff first — the user sometimes edits files by hand, and the live file is the source of truth. To see which tracked desktop files changed in `$HOME`:

```bash
cd ~/projects/dotfiles
for f in $(git ls-files .config/niri .config/xkb); do cmp -s "$f" "$HOME/$f" || echo "changed: $f"; done
```

If nothing is listed, the repo is already in sync; say so and offer to commit if anything is staged.

`~/.config/DankMaterialShell/settings.json` is **not** tracked. It holds all DMS settings (bar layout, mouse, keyboard). Ask the user before adding it; it can contain machine-specific values.

### Tracked desktop files

| Path | Notes |
|---|---|
| `.config/niri/config.kdl` | main niri config |
| `.config/niri/dms/{outputs,windowrules,binds,input}.kdl` | DMS-generated, but included by config.kdl, so niri can't load without them |
| `.config/xkb/symbols/us-no`, `.config/xkb/rules/evdev.xml` | custom keyboard layout |
| `.claude/skills/dotfiles/` | this skill (symlinked to `~/.config/claude/skills/dotfiles`) |

Not tracked on purpose: `config.kdl.backup*`, DMS files config.kdl doesn't include (`colors`, `layout`, `alttab`, `cursor`, `wpblur`), `xkb/input-sources.backup`.

## Branches and commits

- `main`, per-host branches (`host-cachyos`), feature branches (`feat-niri`).
- Commit messages: conventional style, `type(scope): summary`, e.g. `feat(niri): …`, `fix(ssh): …`, `chore(ansible): …`. Scope = the program.
- End every commit message with the org trailer: `Co-Authored-By: Bifrost <bifrost@upheads.no>`.
- Only commit or push when the user asks.
