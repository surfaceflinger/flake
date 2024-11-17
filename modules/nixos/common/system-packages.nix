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
      nano
      ncdu
      nixpkgs-fmt
      ouch
      pv
      rage
      ripgrep
      shellcheck
      speedtest-go
      wget
      (writeScriptBin "7z" ''exec 7zz "$@"'')
      (writeScriptBin "goto-nix" ''cd $(nix build -L --print-out-paths --no-link "$@".out) && $SHELL'')
      (writeScriptBin "jq" ''exec gojq "$@"'')
      yq-go

      # system utilities
      bottom
      config.boot.kernelPackages.cpupower
      pciutils
      pfetch-rs
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
      buffer
      gnome-obfuscate
      lorem
      papers

      # media
      krita
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
