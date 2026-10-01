# Setup guide for new computers

1. Create [SSH Key](~/.ssh/readme.md)
2. Create dotfiles alias
	`alias dotfiles='/usr/bin/git --git-dir="$HOME/.local/share/dotfiles/git" --work-tree="$HOME"'`
3. Run the following commands:
```bash
mkdir -p $HOME/.local/share/dotfiles/git
dotfiles init
dotfiles remote add origin ssh://git@codeberg.org/kobyon/dotfiles.git
dotfiles fetch
dotfiles checkout -f main
```
4. Relogg
