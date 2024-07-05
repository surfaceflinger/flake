{ inputs, ... }:
{
  imports = [
    ./git.nix
    inputs.nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = "24.05";
}
