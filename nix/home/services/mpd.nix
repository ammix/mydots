{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mpc
  ];

  programs.rmpc.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    dbFile = "${config.home.homeDirectory}/Music/database";
    playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
  };
}
