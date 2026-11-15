# Dotfiles role: symlinks the folders in files/ into $HOME (see defaults/main.yaml).

# Create/refresh the symlinks
apply:
    ansible-playbook dotfiles.yaml -K

# Dry run with diff
check:
    ansible-playbook dotfiles.yaml --check --diff
