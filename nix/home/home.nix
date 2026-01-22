{ config, ... }:

{
  imports = [
    ./shell
    ./apps
    ./dev
    ./theme.nix
    ./services
    ./env.nix
    ./sops.nix
    ./gnome.nix
  ];

  home = {
    username = "maxim";
    homeDirectory = "/var/home/maxim";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    homeFlake = "${config.home.homeDirectory}/mydots/nix";
  };

  systemd.user.startServices = "sd-switch";
}
