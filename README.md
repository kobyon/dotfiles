# dotfiles

An Ansible role that symlinks per-program folders from `files/` into `$HOME`. The repo can be cloned anywhere; the links point at whatever checkout ran the playbook. The repo itself holds no symlinks: `dotfiles_links` in `defaults/main.yaml` creates all of them.

## New machine

### CachyOS (SDDM + niri + noctalia, default install)

```bash
sudo pacman -S --needed git ansible just   # the full `ansible` package, not ansible-core: the role needs community.general
gh auth login   # or have an SSH key on GitHub: the repo is private
git clone git@github.com:kobyon/dotfiles.git ~/projects/dotfiles   # any path works
cd ~/projects/dotfiles
just check   # dry run, asks for the sudo password
just apply
```

`just apply` installs packages with pacman, so run it from a terminal inside the running session (it enables a systemd *user* service). It does this:

- Moves any existing config at a link destination (e.g. `~/.config/niri`) to `<dest>.pre-dotfiles`.
- Installs dux-shell (DMS). Removing noctalia is off by default (`desktop_shell_prune: false`), but `noctalia-qs` conflicts with `quickshell`, so on a machine that still has noctalia run `ansible-playbook dotfiles.yaml -K -e desktop_shell_prune=true` instead of `just apply`.
- Enables `dms.service`, installs zsh and makes it the login shell.

**Log out and back in afterwards**: the DMS shell, the new niri config and the zsh login shell all start with the next session. Keep a TTY (Ctrl+Alt+F3) handy the first time.

### Other (Debian/Ubuntu)

```bash
sudo apt install git ansible-core just
```

The package tasks use pacman, so the run links the files and then stops at the zsh install step there.

## Day to day

- `~/.config/niri` is a link to `files/niri`, so any edit, including DMS rewriting `dms/*.kdl`, shows up in `git status` straight away. Test live, then commit.
- **Track a new program:** move its folder to `files/<program>`, add `{ src: <program>, dest: .config/<program> }` to `dotfiles_links`, then run `just apply`. Add runtime junk the program writes there to `.gitignore`.
- **Moved the repo?** Run `just apply` from the new location to re-point the links.
- A real file or folder already at a link destination is moved to `<dest>.pre-dotfiles`, never overwritten.

## Layout

```
files/<program>/   static config, one folder per program (niri, xkb, shell, git, nvim, task, npm, vscode, ssh*, …)
                   * files/ssh is a backup only, not linked
defaults/main.yaml dotfiles_links (src under files/ -> dest under $HOME), shell plugin clones
tasks/             the role
dotfiles.yaml      playbook (localhost) that includes this repo as a role
.claude/skills/dotfiles/   Claude Code skill, linked to ~/.config/claude/skills/dotfiles
```

oh-my-zsh and powerlevel10k are cloned into `files/shell/zsh/` if missing (gitignored, never updated).


Personal reminder for what the different folders under ~/.local/ is used for.

bin - binary files.  Systemlinkes to lib, opt or scripts
src - git repos and other source code.  Should contain little to no compiled code
lib - compiled software used for programs not intended to be launced by the user (me)
opt - downloaded software as .tar.xx or AppImages.  Usually systemlinked to bin, or launced by .desktop files

