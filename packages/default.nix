{ self, inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      packages = {
        # re-export our packages
        inherit (pkgs)
          firefox-gnome-theme
          gnome-gravatar
          gnome-weather-set
          gpucache
          gradience
          krisp-patch
          rasdaemon
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
        overlays = [ self.overlays.default ];
      };
    };

  flake.overlays.default = _final: prev: {
    # Custom packages
    firefox-gnome-theme = prev.callPackage ./firefox-gnome-theme { };
    gnome-gravatar = prev.callPackage ./gnome-gravatar { };
    gnome-weather-set = prev.callPackage ./gnome-weather-set { };
    gpucache = prev.callPackage ./gpucache { };
    gradience = prev.callPackage ./gradience { };
    krisp-patch = prev.callPackage ./krisp-patch { };
    rasdaemon = prev.callPackage ./rasdaemon { };
    swift-backup = prev.callPackage ./swift-backup { };
    timedoctor-desktop = prev.callPackage ./timedoctor-desktop { };
  };
}
