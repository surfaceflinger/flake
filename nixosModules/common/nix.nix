{ inputs, ... }: {
  # Nix/nixpkgs                                                                                                                                                                                                                                                                          
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;

  system.stateVersion = "22.11";
}
