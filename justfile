STOW_DIRS := 'walls/ env/ term/ qute/ nvim/'

default: help

# Dotfile Management
stow:
    @echo 'Symlinking dotfiles...'
    @stow --restow {{STOW_DIRS}}

delete:
    @echo 'Deleting all dotfile symlinks...'
    @stow --delete {{STOW_DIRS}}

# System Initialization
init: system-setup bootstrap-nix
    @echo 'System initialization complete.'

bootstrap-nix:
    @echo 'Bootstrapping Nix environment...'
    @curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install ostree --no-confirm
    @fish -c 'nix run home-manager -- switch --flake ~/mydots/nix'
    @fish -c 'home-manager switch --flake /var/home/maxim/mydots/nix#maxim'

system-setup: stow
    @echo 'Running interactive system setup script...'
    @./scripts/init-gum.sh

# Help
help:
    @echo 'Available commands:'
    @echo '  just stow           (s)  - Symlink dotfiles using Stow'
    @echo '  just delete         (d)  - Delete all symlinked dotfiles'
    @echo '  just init           (i)  - Run full system setup'
    @echo '  just commit "msg"        - Commit changes with Jujutsu'
    @echo '  just push "msg"     (p)  - Commit and push changes'
    @echo '  just clean               - Run jj garbage collection'
