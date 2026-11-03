# dotfiles

An Ansible role that symlinks per-program folders from `files/` into `$HOME`. The repo can be cloned anywhere; the links point at whatever checkout ran the playbook. The repo itself holds no symlinks: `dotfiles_links` in `defaults/main.yaml` creates all of them.

## New machine

```bash
sudo apt install git ansible-core just
git clone git@github.com:kobyon/dotfiles.git ~/projects/dotfiles   # any path works
cd ~/projects/dotfiles
just check   # dry run
just apply
```

## Day to day

- `~/.config/niri` is a link to `files/niri`, so any edit, including DMS rewriting `dms/*.kdl`, shows up in `git status` straight away. Test live, then commit.
- **Track a new program:** move its folder to `files/<program>`, add `{ src: <program>, dest: .config/<program> }` to `dotfiles_links`, then run `just apply`. Add runtime junk the program writes there to `.gitignore`.
- **Moved the repo?** Run `just apply` from the new location to re-point the links.
- A real file or folder already at a link destination is moved to `<dest>.pre-dotfiles`, never overwritten.

## Layout

```
files/<program>/   static config, one folder per program (niri, xkb, shell, git, nvim, task, npm, hypr, vscode, ssh*, …)
home/              leftover old config (readmes), not deployed
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

