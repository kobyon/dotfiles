# Dotfiles role: symlinks the folders in files/ into $HOME (see defaults/main.yaml).

# Install packages and create/refresh the symlinks (asks for the sudo password)
apply:
    ansible-playbook dotfiles.yaml --ask-become-pass

# Dry run with diff
check:
    ansible-playbook dotfiles.yaml --check --diff --ask-become-pass
