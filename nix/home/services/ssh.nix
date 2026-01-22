{
  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github" = {
        host = "github.com";
        hostname = "github.com";
        user = "git";
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519_sk";
      };
      "cloud" = {
        host = "cloud";
        hostname = "192.168.178.46";
        user = "my";
        identityFile = "~/.ssh/id_ed25519_sk";
      };
    };
  };
}
