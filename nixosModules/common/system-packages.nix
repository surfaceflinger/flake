{ config
, lib
, pkgs
, ...
}:
{
  # Other software
  environment.systemPackages =
    with pkgs;
    [
      # CLI/TUI tools
      _7zz
      bat
      deadnix
      eza
      file
      jq
      libarchive
      nano
      ncdu
      nixpkgs-fmt
      ouch
      rage
      ripgrep
      screen
      shellcheck
      signify
      unrar
      wget
      yq
      (writeScriptBin "7z" ''exec 7zz "$@"'')

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
      amberol
      halloy
      vscode
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
      (nvtop.override { nvidia = false; })
      pavucontrol
      radeontop
    ];

  programs = {
    adb.enable = config.services.xserver.enable;
    git.enable = true;
    gnupg.agent.enable = true;
  };
}
