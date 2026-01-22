{ config, pkgs, lib, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      "adjust-open" = "best";
      "guioptions" = "none";
    };

    mappings = {
      "j" = ''feedkeys "<C-Down>"'';
      "k" = ''feedkeys "<C-Up>"'';
    };
  };
} 