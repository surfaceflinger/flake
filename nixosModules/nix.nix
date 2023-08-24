{ inputs, ... }: {
  # Nix/nixpkgs                                                                                                                                                                                                                                                                          
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
    extraOptions = ''                                                                                                                                                                                                                                                                    
       experimental-features = nix-command flakes ca-derivations                                                                                                                                                                                                                          
     '';
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;

  system.stateVersion = "22.11";
}
