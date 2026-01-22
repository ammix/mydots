{ pkgs, ... }:

{
  home.packages = with pkgs; [ lazygit ];

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
      format = "ssh";
    };

    ignores = [
      "Session.vim"
      "/.direnv/"
      ".env"
    ];

    settings = {
      user.name = "ammix";
      user.email = "maxim@ammix.dev";

      credential.helper = "store";
      init.defaultBranch = "main";
      help.autocorrect = "immediate";

      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      rerere.enabled = true;

      aliases = {
        abandon = "!git reset --hard HEAD~1 && git clean -fd";
      };

      color = {
        ui = true;
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings.editor = "nvim";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showBranchCommitHash = true;
        nerdFontsVersion = "3";
      };
      git = {
        parseEmoji = true;
        autoFetch = false;
      };
    };
  };
}
