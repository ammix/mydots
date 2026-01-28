{ config, lib, ... }:

{
  home.sessionVariables = {
    NH_HOME_FLAKE = "${config.home.homeDirectory}/mydots/nix";
    EDITOR = "${config.home.homeDirectory}/.local/share/bob/nvim-bin/nvim";
    VISUAL = "${config.home.homeDirectory}/.local/share/bob/nvim-bin/nvim";
    SUDO_EDITOR = "${config.home.homeDirectory}/.local/share/bob/nvim-bin/nvim";
    MANPAGER = "nvim +Man!";
    __HM_SESS_VARS_SOURCED = "";
    PKG_CONFIG_PATH = "/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH";

    MAKEFLAGS = "--jobs=$(nproc)";

    MANROFFOPT = "-c";
    VIRTUAL_ENV_DISABLE_PROMPT = "1";
    FZF_DEFAULT_OPTS = lib.mkForce ''
      --color=bg:-1,bg+:-1,preview-bg:-1,hl:underline,hl+:underline,fg:#cdd6f4,fg+:#cdd6f4,header:#b4befe,info:#b4befe,marker:#b4befe,pointer:#b4befe,prompt:#b4befe,spinner:#f5e0dc
    '';
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.local/share/bob/nvim-bin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
  ];
}
