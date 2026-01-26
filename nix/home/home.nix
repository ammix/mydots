{ config, ... }:

{
  imports = [
    ./shell
    ./apps
    ./dev
    ./services
    ./theme.nix
    ./env.nix
    ./sops.nix
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
