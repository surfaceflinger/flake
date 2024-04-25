{ inputs, ... }:
{
  imports = [
    ./git.nix
    inputs.nix-index-database.hmModules.nix-index
    ./nix.nix
  ];

  home.stateVersion = "24.05";
}
