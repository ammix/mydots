{ pkgs, ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "ammix";
        email = "maxim@ammix.dev";
      };

      ui = {
        editor = "nvim";
        paginate = "never";
        "default-command" = "log";
        merge-editor = ["meld" "$left" "$base" "$right" "-o" "$output"];
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };

      snapshot = {
        "max-new-file-size" = 99903360;
      };
    };
  };

  programs.jjui.enable = true;
}
