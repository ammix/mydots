{ config, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      set fish_greeting
      set -gx __HM_SESS_VARS_SOURCED ""
    '';

    # Fix immutable home dir not defaulting to symlink on cosmic
    interactiveShellInit = ''
      if string match -q "/var/home/*" (pwd)
        cd (string replace -r "^/var/home/" "/home/" (pwd))
      end
    '';

    functions = {
      __history_previous_command = ''
        switch (commandline -t)
          case "!"
            commandline -t $history[1]
            commandline -f repaint
          case "*"
            commandline -i !
        end
      '';
      __history_previous_command_arguments = ''
        switch (commandline -t)
          case "!"
            commandline -t ""
            commandline -f history-token-search-backward
          case "*"
            commandline -i '$'
        end
      '';
      history = "builtin history --show-time='%F %T '";
      backup = "cp $argv[1] $argv[1].bak";
      copy = ''
        set count (count $argv | tr -d \n)
        if test "$count" = 2; and test -d "$argv[1]"
            set from (echo $argv[1] | string trim --right --chars=/)
            set to (echo $argv[2])
            command cp -r $from $to
        else
            command cp $argv
        end
      '';
      cleanup = ''
        nix-collect-garbage -d
        flatpak uninstall --unused --assumeyes
      '';
      dev = ''
        set selected (find ~/dev -mindepth 1 -maxdepth 1 -type d | fzf)
        if test -n "$selected"
            cd $selected
            nvim
        end
      '';
      update = ''
        nix flake update --flake ${config.home.sessionVariables.NH_HOME_FLAKE}
        nh home switch
        bob update
        flatpak update --assumeyes
      '';
      targz = ''
        set -l dir_name (string trim --right --char=/ $argv[1])
        tar -czvf "$dir_name.tar.gz" "$dir_name"
        echo "Created '$dir_name.tar.gz'"
      '';
      extract = ''
        switch "$argv[1]"
            case "*.tar" "*.tar.gz" "*.tgz" "*.tar.bz2" "*.tbz2" "*.tar.xz" "*.txz" "*.tar.zst" "*.tzst"
                tar -xvf "$argv[1]"
            case "*.zip" "*.7z" "*.rar" "*.jar" "*.war" "*.ear"
                set dirname (path change-extension "" "$argv[1]")
                7zz x "$argv[1]" -o"$dirname"
            case "*.gz"
                gunzip "$argv[1]"
            case "*.bz2"
                bunzip2 "$argv[1]"
            case "*"
                echo "Cannot extract '$argv[1]': Unknown format."
                return 1
        end
      '';
    };

    shellAliases = {
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";
    };

    shellAbbrs = {
      hm = "home-manager --flake ${config.home.sessionVariables.NH_HOME_FLAKE}#maxim";
      rm = "rm -Iv";
      rmr = "rm -vrf";
      fu = "flatpak uninstall --delete-data";
      init-music = " rsync -havP -e ssh my@cloud:/home/my/navi/music/ ~/Music/";

      # Git
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit";
      gcm = "git commit -m";
      gst = "git status";
      gp = "git push";
      gpl = "git pull";
      gd = "git diff";
      gcl = "git clone";

      # Jujutsu
      jja = "jj abandon";
      jjg = "jj git";
      jjgc = "jj git clone";
      jjs = "jj squash";
      jjc = "jj commit";
      jjcm = "jj commit -m";
      jji = "jj git init --colocate";
      jjp = "jj git push";
      jjf = "jj git fetch --all-remotes";
      jjb = "jj bookmark set -r";
      jjbp = "jj bookmark set main -r@- && jj git push";
    };

    binds = {
      # bang-bang bindings
      "!".command = "__history_previous_command";
      # "!".mode = "insert";
      "\\$".command = "__history_previous_command_arguments";
      # "\\$".mode = "insert";

      "ctrl-f".command = "dev";
      "alt-m".command = "dots";
      "alt-a".command = "ammixblue";
    };
  };
}
