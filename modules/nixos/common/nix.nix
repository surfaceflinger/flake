{ inputs, ... }:
{
  # nix/nixpkgs
  imports = [
    inputs.lix-module.nixosModules.default
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    checkConfig = false;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      self.flake = inputs.self;
      tf.flake = inputs.tf;
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
        "https://cache.lix.systems"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  };

  system.stateVersion = "24.05";
}
