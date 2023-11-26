{ inputs, ... }:
{
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  home.sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs\${NIX_PATH:+:$NIX_PATH}";
}
