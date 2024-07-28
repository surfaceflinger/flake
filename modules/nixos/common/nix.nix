{ inputs, ... }:
{
  # nix/nixpkgs
  imports = [
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;
    checkConfig = false;
    registry = {
      self.flake = inputs.self;
      tf.flake = inputs.tf;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };

  system.stateVersion = "24.05";
}
