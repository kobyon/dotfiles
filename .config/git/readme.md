# Setup guide for new computers

1. Create [SSH Key](~/.ssh/readme.md)
2. Create dotfiles alias
	`alias dotfiles='/usr/bin/git --git-dir="$HOME/.local/src/dotfiles/" --work-tree="$HOME"'`
3. Run the following commands:
```bash
mkdir -p ~/.local/src/dotfiles
dotfiles init
dotfiles remote add origin git@github.com:Aresime/dotfiles.git
dotfiles fetch
dotfiles checkout -f main
```
4. Relogg
