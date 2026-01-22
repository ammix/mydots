{
  config,
  lib,
  pkgs,
  ...
}:

{
  dconf = {
    enable = true;
    settings = {
      # "org/gnome/shell" = {
      #   disable-user-extensions = false; # enables user extensions
      #   enabled-extensions = [
      #     pkgs.gnomeExtensions.blur-my-shell.extensionUuid
      #     pkgs.gnomeExtensions.fullscreen-avoider.extensionUuid
      #     pkgs.gnomeExtensions.gsconnect.extensionUuid
      #     pkgs.gnomeExtensions.runcat.extensionUuid
      #   ];
      # };
      "org/gnome/desktop/interface" = {
        # color-scheme = "prefer-dark";
        # gtk-theme = "Adwaita";
        cursor-theme = "Bibata-Modern-Ice";
        cursor-size = 24;
      };
    };
  };
}
