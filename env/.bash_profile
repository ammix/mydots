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

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
. "/home/maxim/.local/share/bob/env/env.sh"

if [ -e /var/home/maxim/.nix-profile/etc/profile.d/nix.sh ]; then . /var/home/maxim/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
