{ self, inputs, ... }: {
  perSystem = { system, pkgs, ... }: {
    packages = {
      # re-export our packages
      inherit (pkgs)
        anime4k
        gpucache
        krisp-patch
        noise-suppression-for-voice
        swift-backup
        ;
    };
    # make pkgs available to all `perSystem` functions
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        self.overlays.default
      ];
    };
  };

  flake.overlays.default = _final: prev: {
    # Custom packages
    anime4k = prev.callPackage ./anime4k { };
    gpucache = prev.callPackage ./gpucache { };
    krisp-patch = prev.callPackage ./krisp-patch { };
    noise-suppression-for-voice = prev.callPackage ./noise-suppression-for-voice { };
    swift-backup = prev.callPackage ./swift-backup { };
  };
}
