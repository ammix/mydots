{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    jq
    poppler
    resvg
  ];

  programs.yazi = {
    enable = true;

    settings = {
      mgr = {
        show_hidden = true;
      };
    };

    plugins = {
      chmod = pkgs.yaziPlugins.chmod;
      mount = pkgs.yaziPlugins.mount;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "g"
            "C"
          ];
          run = "cd ~/dev/";
          desc = "Cd to ~/dev/";
        }
        {
          on = [
            "g"
            "D"
          ];
          run = "cd ~/Documents/";
          desc = "Cd to ~/Documents/";
        }
        {
          on = [
            "g"
            "G"
          ];
          run = "cd ~/Games/";
          desc = "Cd to ~/Games";
        }
        {
          on = [
            "g"
            "p"
          ];
          run = "cd ~/Pictures/";
          desc = "Cd to ~/Pictures";
        }
        {
          on = [
            "g"
            "m"
          ];
          run = "cd ~/Music/";
          desc = "Cd to ~/Music";
        }
        {
          on = [
            "g"
            "s"
          ];
          run = "cd ~/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/";
          desc = "Cd to Steam Games";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Change permission";
        }
        {
          on = "M";
          run = "plugin mount";
        }
      ];
    };
  };
}
