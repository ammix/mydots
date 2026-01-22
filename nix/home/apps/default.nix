{
  pkgs,
  ...
}:

{
  imports = [
    ./yt-dlp.nix
    ./yazi.nix
    ./zathura.nix
    ./cava.nix
  ];

  home.packages = with pkgs; [
    # CMD
    stow
    sops
    age
    tldr
    cbonsai
    peaclock
    gum
    typst
    xlsclients

    # Dependecies
    wl-clipboard
    ugrep
    fd
    jq
    _7zz-rar
    unrar
    unzip
    zip
    pandoc

    # Media
    ffmpeg-full
    imagemagickBig
    libheif
  ];

  # Simple program configurations
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.bottom.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;
  programs.ripgrep.enable = true;
}
