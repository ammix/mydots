{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    atomicparsley
    python312Packages.mutagen
  ];

  programs.yt-dlp = {
    enable = true;
    settings = {
      extract-audio = true;
      audio-format = "best";
      output = "${config.home.homeDirectory}/Music/%(title)s.%(ext)s";
      embed-thumbnail = true;
      add-metadata = true;
      ignore-errors = true;
      playlist-reverse = true;
    };
  };
}
