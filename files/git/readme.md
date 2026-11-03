# Setup guide for new computers

1. Create [SSH Key](~/.ssh/readme.md)
2. Install prerequisites: `sudo apt install git ansible-core just`
3. Clone the dotfiles repo anywhere (e.g. `~/projects/dotfiles`) and deploy:
```bash
git clone git@github.com:kobyon/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles && just apply
```
4. Relogg

See the repo README for details. The old bare-repo `dotfiles` alias is retired.
