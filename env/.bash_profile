# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Source generic profile settings
if [ -f "${HOME}/.profile" ]; then
  . "${HOME}/.profile"
fi

# User specific environment and startup programs
export EDITOR=${HOME}/.local/share/bob/nvim-bin/nvim
export SUDO_EDITOR=${HOME}/.local/share/bob/nvim-bin/nvim
export VISUAL=${HOME}/.local/share/bob/nvim-bin/nvim

if [ -e /var/home/maxim/.nix-profile/etc/profile.d/nix.sh ]; then . /var/home/maxim/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
