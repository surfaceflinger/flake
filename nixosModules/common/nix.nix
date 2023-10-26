{ inputs, ... }: {
  # Nix/nixpkgs                                                                                                                                                                                                                                                                          
  imports = [
    inputs.srvos.nixosModules.mixins-nix-experimental
    inputs.srvos.nixosModules.mixins-trusted-nix-caches
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = ["nixpkgs=flake:nixpkgs"];
  };

  system.stateVersion = "22.11";
}
