{
  config,
  ...
}:

{
  imports = [
    ./fish.nix
    ./starship.nix
    ./fastfetch.nix
    ./nushell.nix
    ./carapace.nix
  ];

  programs.lsd.enable = true;

  programs.eza = {
    enable = true;
    icons = "always";
    colors = "always";
    extraOptions = [ "--group-directories-first" ];
  };

  home.shellAliases = {
    # Nix
    hmu = "nix flake update --flake ${config.home.sessionVariables.NH_HOME_FLAKE}";
    nhs = "nh home switch ~/mydots/nix/";
    hmn = "home-manager news --flake ${config.home.sessionVariables.NH_HOME_FLAKE}#maxim";
    # Bat
    cat = "bat --style header --style snip --style changes --style header";
    less = "bat --paging=always --pager=less";
    # Common
    ".." = "cd ..";
    "..." = "cd ../..";

    # Zoxide
    c = "z";
    ci = "zi";

    # sudo-rs
    sudo = "sudo-rs";
    su = "su-rs";
    # sudoedit = "sudoedit-rs";

    grep = "ugrep --color=auto";
    ip = "ip -color";
    lg = "lazygit";
    lj = "jjui";
    ifone = "rsync -ar ~/phone/DCIM/* /home/maxim/bkiphone";
    # Editing
    v = "nvim";
    svim = "sudoedit";
    # Applications
    yt = "yt-dlp";
    ff = "fastfetch";
    bonsai = "cbonsai -S -t 10 --life 60";
    # Journalctl
    jctl = "journalctl -p 3 -xb";
    # ssh
    sshc = "ssh cloud";
    navi = "rsync -havP --exclude '*.m3u' --delete -e ssh ~/Music/* my@cloud:/home/my/navi/music";
  };
}
