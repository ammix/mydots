{ config, lib, ... }:

{
  home.sessionVariables = {
    NH_HOME_FLAKE = "${config.home.homeDirectory}/mydots/nix";
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    __HM_SESS_VARS_SOURCED = "";
    PKG_CONFIG_PATH = "/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH";

    # Application behavior hints / Driver settings
    NIXOS_OZONE_WL = "1";
    OZONE_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";

    RADV_PERFTEST = "video_decode,video_encode";
    MAKEFLAGS = "--jobs=$(nproc)";

    MANROFFOPT = "-c";
    VIRTUAL_ENV_DISABLE_PROMPT = "1";
    FZF_DEFAULT_OPTS = lib.mkForce ''
      --color=bg:-1,bg+:-1,preview-bg:-1,hl:underline,hl+:underline,fg:#cdd6f4,fg+:#cdd6f4,header:#b4befe,info:#b4befe,marker:#b4befe,pointer:#b4befe,prompt:#b4befe,spinner:#f5e0dc
    '';
    XCURSOR_PATH = "\${XCURSOR_PATH}:\${HOME}/.local/share/icons";
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
