{ config, ... }:

{
  sops = {
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      "github-token" = { };
      "brave-search-api-key" = { };
      "openrouter-api-key" = { };
    };
  };

  home.sessionVariables = {
    GITHUB_TOKEN = "$(cat ${config.sops.secrets."github-token".path})";
    BRAVE_SEARCH_API_KEY = "$(cat ${config.sops.secrets."brave-search-api-key".path})";
    OPENROUTER_API_KEY = "$(cat ${config.sops.secrets."openrouter-api-key".path})";
  };
}
