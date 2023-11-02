{ self, inputs, ... }: {
  perSystem = { system, pkgs, ... }: {
    packages = {
      # re-export our packages
      inherit (pkgs)
        anime4k
        gpucache
        gradience
        krisp-patch
        swift-backup
        timedoctor-desktop
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
    gradience = prev.callPackage ./gradience { };
    krisp-patch = prev.callPackage ./krisp-patch { };
    swift-backup = prev.callPackage ./swift-backup { };
    timedoctor-desktop = prev.callPackage ./timedoctor-desktop { };
  };
}
