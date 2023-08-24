{ self, inputs, ... }: {
  perSystem = { system, pkgs, ... }: {
    packages = {
      # re-export our packages
      inherit (pkgs)
        anime4k
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
    timedoctor-desktop = prev.callPackage ./timedoctor-desktop { };
    # Overrides
    discord = prev.discord.override { withOpenASAR = true; };
    google-chrome = prev.google-chrome.override { commandLineArgs = "--enable-features=WebUIDarkMode --force-dark-mode"; };
    mpv = prev.wrapMpv prev.mpv-unwrapped { scripts = [ prev.mpvScripts.inhibit-gnome prev.mpvScripts.quality-menu prev.mpvScripts.mpris ]; };
  };
}
