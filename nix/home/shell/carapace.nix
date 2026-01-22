{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.carapace = {
    enable = false;
  };

  home.file = {
    ".config/carapace/specs" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/mydots/specs";
    };
  };
}
