{ inputs, osConfig, ... }:
{
  imports = [
    ./git.nix
    inputs.nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
