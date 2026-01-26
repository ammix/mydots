{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = "Bibata-Modern-Ice";
        cursor-size = 24;
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };
}
