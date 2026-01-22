#!/usr/bin/env bash

set -e

check_dependencies() {
  gum log --level info "Checking for required tools..."
  for cmd in gum git flatpak systemctl sudo; do
    if ! command -v "$cmd" &>/dev/null; then
      gum log --level error "Command not found: $cmd. Please install it and try again."
      exit 1
    fi
  done
  gum log --level info "All dependencies are installed."
}

copy_secrets() {
  gum style --border normal --margin "1" --padding "1" "Secrets Installation (SSH & Keyrings)"
  local ssh_source_dir="$HOME/keys/.ssh"
  local ssh_dest_dir="$HOME/.ssh"
  local keyring_source_dir="$HOME/keys/keyrings"
  local keyring_dest_dir="$HOME/.local/share/keyrings"

  if ! [ -d "$ssh_source_dir" ] && ! [ -d "$keyring_source_dir" ]; then
    gum log --level warn "Source directories not found in '$HOME/keys'. Skipping."
    return
  fi

  if gum confirm "Copy secrets (SSH keys, GNOME Keyrings) from '$HOME/keys'?"; then

    if [ -d "$ssh_source_dir" ]; then
      gum log --level info -- "--- Processing SSH keys ---"
      if [ -d "$ssh_dest_dir" ]; then
        gum log --level error "SSH destination '$ssh_dest_dir' already exists."
        if gum confirm "OVERWRITE with keys from '$ssh_source_dir'? THIS IS DESTRUCTIVE."; then
          local backup_dir="${ssh_dest_dir}.bak.$(date +%s)"
          gum spin --title "Backing up existing SSH keys..." -- mv "$ssh_dest_dir" "$backup_dir"
          gum log --level info "Existing SSH keys backed up to '$backup_dir'."

          gum spin --title "Copying new SSH keys..." -- cp -a "$ssh_source_dir" "$ssh_dest_dir"
          gum spin --title "Applying correct permissions..." -- bash -c "chmod 700 '$ssh_dest_dir' && find '$ssh_dest_dir' -type f -name '*.pub' -exec chmod 644 {} + && find '$ssh_dest_dir' -type f -not -name '*.pub' -exec chmod 600 {} +"
          gum log --level info "SSH keys copied and permissions set."
        else
          gum log --level warn "Skipping SSH key copy."
        fi
      else
        gum spin --title "Copying SSH keys..." -- cp -a "$ssh_source_dir" "$ssh_dest_dir"
        gum spin --title "Applying correct permissions..." -- bash -c "chmod 700 '$ssh_dest_dir' && find '$ssh_dest_dir' -type f -name '*.pub' -exec chmod 644 {} + && find '$ssh_dest_dir' -type f -not -name '*.pub' -exec chmod 600 {} +"
        gum log --level info "SSH keys copied and permissions set."
      fi
    fi

    if [ -d "$keyring_source_dir" ]; then
      gum log --level info -- "--- Processing GNOME Keyrings ---"

      if [ -d "$keyring_dest_dir" ]; then
        gum log --level error "Keyrings destination '$keyring_dest_dir' already exists."
        if gum confirm "OVERWRITE with keyrings from '$keyring_source_dir'? THIS IS DESTRUCTIVE."; then
          local backup_dir="${keyring_dest_dir}.bak.$(date +%s)"
          gum spin --title "Backing up existing keyrings..." -- mv "$keyring_dest_dir" "$backup_dir"
          gum log --level info "Existing keyrings backed up to '$backup_dir'."

          gum spin --title "Copying new keyrings..." -- cp -a "$keyring_source_dir" "$keyring_dest_dir"
          gum log --level info "GNOME Keyrings copied."
        else
          gum log --level warn "Skipping GNOME Keyring copy."
        fi
      else
        mkdir -p "$(dirname "$keyring_dest_dir")"
        gum spin --title "Copying GNOME Keyrings..." -- cp -a "$keyring_source_dir" "$keyring_dest_dir"
        gum log --level info "GNOME Keyrings copied."
      fi
    fi
  else
    gum log --level warn "Skipping copy of all secret files."
  fi
}

setup_flatpaks() {
  gum style --border normal --margin "1" --padding "1" --border-foreground 212 "Flatpak Setup"

  gum log --level info "Checking Flathub remote..."

  if ! flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; then

    gum log --level error "Failed to add Flathub remote. Check permissions."
    exit 1
  fi

  if gum confirm "Install recommended Flatpaks?"; then
    local flatpaks=(
      io.gitlab.librewolf-community app.zen_browser.zen com.discordapp.Discord
      com.heroicgameslauncher.hgl net.lutris.Lutris com.vysp3r.ProtonPlus
      md.obsidian.Obsidian com.valvesoftware.Steam com.github.tchx84.Flatseal
      io.bassi.Amberol app.drey.EarTag de.schmidhuberj.DieBahn
      io.github.idevecore.Valuta dev.edfloreshz.CosmicTweaks
      com.github.ADBeveridge.Raider info.febvre.Komikku com.belmoussaoui.Decoder
      org.gnome.gitlab.YaLTeR.Identity com.github.finefindus.eyedropper
      com.yubico.yubioath com.bitwarden.desktop
      io.github.flattool.Warehouse com.tutanota.Tutanota
      io.github.kolunmi.Bazaar org.gnome.gitlab.YaLTeR.VideoTrimmer
      io.github.celluloid_player.Celluloid
      io.github.Faugus.faugus-launcher org.jdownloader.JDownloader
      org.gnome.Papers com.github.jeromerobert.pdfarranger
    )

    gum spin --title "Installing ${#flatpaks[@]} flatpaks..." -- \
      flatpak install --system -y "${flatpaks[@]}"

    gum log --level info "Flatpak installation complete."
  else
    gum log --level warn "Skipping Flatpak installs."
  fi
}

migrate_fedora_flatpaks() {
  gum style --border normal --margin "1" --padding "1" --border-foreground 212 "Fedora Flatpak Migration"

  if ! gum confirm "Migrate system Flatpaks from Fedora remote to Flathub?"; then
    gum log --level warn "Skipping Fedora Flatpak migration."
    return
  fi

  local fedora_flatpak_list="/tmp/fedora_flatpaks.txt"

  gum spin --spinner dot --title "Finding system apps from the Fedora remote..." -- \
    bash -c "flatpak list --system --app-runtime=org.fedoraproject.Platform --columns=application > '$fedora_flatpak_list'"

  if [ ! -s "$fedora_flatpak_list" ]; then
    gum log --level info "No applications found. Nothing to do."
    rm -f "$fedora_flatpak_list"
    return
  fi

  gum style --bold "The following applications will be migrated to the Flathub remote:"
  cat "$fedora_flatpak_list" | gum style --padding "0 4"
  echo

  if ! gum confirm "Do you want to proceed with the migration?"; then
    gum log --level warn "Migration cancelled by user."
    rm -f "$fedora_flatpak_list"
    return
  fi

  while read -r app_id; do
    [ -z "$app_id" ] && continue

    gum style --foreground 212 "Migrating: $app_id"

    if gum spin --spinner line --title "Installing '$app_id' from Flathub" -- \
      flatpak install --system --assumeyes flathub "$app_id"; then

      gum log --level info "Successfully installed '$app_id'."

      if gum spin --spinner line --title "Uninstalling system version of '$app_id'" -- \
        flatpak uninstall --system --assumeyes "$app_id"; then
        gum log --level info "System version removed."
      else
        gum log --level error "Failed to uninstall system version."
      fi
    else
      gum log --level error "Failed to install from Flathub."
    fi
    gum style -- "---"

  done <"$fedora_flatpak_list"

  rm -f "$fedora_flatpak_list"

  gum style \
    --border double \
    --align center \
    --width 50 \
    --margin "1 2" --padding "1 2" \
    "Migration Complete" "You can now consider removing the system Fedora remote if it's no longer needed:
flatpak remote-delete --system fedora"
}

main() {
  gum style --border double --margin "1" --padding "1" --border-foreground 242 \
    "Ammix System Setup Script" \
    "This script will guide you through setting up your system."

  check_dependencies
  copy_secrets
  setup_flatpaks
  migrate_fedora_flatpaks

  gum style --border normal --margin "1" --padding "1" --border-foreground 212 "Script finished successfully."
}

main
