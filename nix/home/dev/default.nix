{ pkgs, inputs, ...}:

{
  imports = [
    ./jujutsu.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    # neovim
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    zenity
    zig
    zls
    odin
    ols
    cargo
    rust-analyzer
    clippy
    clang
    clang-tools
    meson
    ninja
    tinymist
    gnumake
    cmake
    gopls
    tree-sitter
    nodePackages_latest.nodejs
    nil
    nixfmt
    alejandra
    prettier
    stylua
    fish-lsp
    harper
    basedpyright
    bash-language-server
    shfmt
    yaml-language-server
    lua-language-server
    vscode-json-languageserver
    hadolint
    yamlfmt
    tokei
    gdb
    lldb
    delve
    gf
    meld
  ];

  programs.cargo.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # config = {
    #   global.hide_env_diff = true;
    # };
    silent = true;
  };

  programs.bacon = {
    enable = true;
    settings = {
      jobs = {
        default = {
          command = [
            "cargo"
            "build"
            "--all-features"
            "--color"
            "always"
          ];
          need_stdout = true;
        };
      };
    };
  };

  programs.opencode = {
    enable = true;
  };

  programs.uv.enable = true;

  programs.ruff = {
    enable = true;
    settings = {
      line-length = 120;
      per-file-ignores = {
        "__init__.py" = [ "F401" ];
      };
      lint = {
        ignore = [ ];
      };
    };
  };

  programs.bun = {
    enable = true;
    settings = {
      telemetry = false;
    };
  };

  programs.go = {
    enable = true;
    telemetry.mode = "off";
  };
}
