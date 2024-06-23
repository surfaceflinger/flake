{
  config,
  lib,
  pkgs,
  ...
}:
{
  # other software
  environment.systemPackages =
    with pkgs;
    [
      # cli/tui tools
      _7zz
      abduco
      bat
      deadnix
      eza
      file
      gojq
      ipgrep
      libarchive
      nano
      ncdu
      nixpkgs-fmt
      nix-tree
      ouch
      pv
      rage
      ripgrep
      shellcheck
      wget
      (writeScriptBin "7z" ''exec 7zz "$@"'')
      (writeScriptBin "goto-nix" ''cd $(nix build -L --print-out-paths --no-link "$@".out) && $SHELL'')
      (writeScriptBin "jq" ''exec gojq "$@"'')
      yq

      # system utilities
      bottom
      config.boot.kernelPackages.cpupower
      fastfetch
      pciutils
      psmisc
      usbutils

      # network
      doggo
      goaccess
      inetutils
      magic-wormhole-rs
      rustscan
    ]
    ++ lib.optionals config.services.xserver.enable [
      # desktop software
      curtail
      gnome-obfuscate
      lorem
      warp

      # media
      krita
      (mpv.override {
        scripts = [
          mpvScripts.inhibit-gnome
          mpvScripts.quality-menu
          mpvScripts.mpris
        ];
      })
      yt-dlp

      # system utilities
      glxinfo
      libva-utils
      (nvtopPackages.full.override { nvidia = false; })
      pavucontrol
    ];

  programs = {
    adb.enable = config.services.xserver.enable;
    git.enable = true;
    gnupg.agent.enable = true;
  };
}
