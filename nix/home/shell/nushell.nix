{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.shell.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;
    plugins = with pkgs; [
      nushellPlugins.query
      nushellPlugins.polars
      nushellPlugins.gstat
    ];
    extraConfig = builtins.readFile ./config.nu;
  };
}
