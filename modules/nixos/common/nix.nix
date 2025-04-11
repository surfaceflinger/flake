{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # nix/nixpkgs
  imports = [
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      use-xdg-base-directories = true;
      experimental-features = lib.mkForce [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "fetch-closure"
        "flakes"
        "nix-command"
        "recursive-nix"
      ];
    };
    registry = {
      self.flake = inputs.self;
      tf.flake = inputs.tf;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "24.11";
}
