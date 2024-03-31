{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Other software
  environment.systemPackages =
    with pkgs;
    [
      # CLI/TUI tools
      _7zz
      abduco
      bat
      deadnix
      eza
      file
      gojq
      libarchive
      nano
      ncdu
      nixpkgs-fmt
      nix-tree
      ouch
      rage
      ripgrep
      shellcheck
      wget
      (writeScriptBin "7z" ''exec 7zz "$@"'')
      (writeScriptBin "jq" ''exec gojq "$@"'')
      yq

      # System utilities
      bottom
      config.boot.kernelPackages.cpupower
      pciutils
      pfetch-rs
      psmisc
      usbutils

      # Network
      doggo
      goaccess
      inetutils
      magic-wormhole-rs
      rustscan
    ]
    ++ lib.optionals config.services.xserver.enable [
      # Desktop software
      halloy
      xfce.mousepad

      # Media
      krita
      (mpv.override {
        scripts = [
          mpvScripts.inhibit-gnome
          mpvScripts.quality-menu
          mpvScripts.mpris
        ];
      })
      yt-dlp

      # System utilities
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
