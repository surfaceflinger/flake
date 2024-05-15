{ inputs, pkgs, ... }:
{
  # Nix/nixpkgs                                                                                                                                                                                                                                                                          
  imports = [
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    checkConfig = false;
    package = pkgs.lix;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      self.flake = inputs.self;
    };
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings = {
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  };

  system.stateVersion = "24.05";
}
