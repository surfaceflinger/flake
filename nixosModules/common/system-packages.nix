{ config, lib, pkgs, ... }: {
  # Other software
  environment.systemPackages = with pkgs; [
    # CLI/TUI tools
    bat
    deadnix
    eza
    file
    nano
    ncdu
    nixpkgs-fmt
    ouch
    rage
    ripgrep
    screen
    signify
    tree
    wget

    # System utilities
    config.boot.kernelPackages.cpupower
    lm_sensors
    pciutils
    psmisc
    usbutils
    zenith

    # Network
    doggo
    inetutils
    magic-wormhole-rs
    rustscan
  ] ++ lib.optionals config.services.xserver.enable [
    # Desktop software
    burpsuite
    gnome-feeds
    halloy
    vscode
    xfce.mousepad

    # Media
    krita
    lollypop
    (mpv.override { scripts = [ mpvScripts.inhibit-gnome mpvScripts.quality-menu mpvScripts.mpris ]; })
    yt-dlp
  ];

  programs = {
    adb.enable = config.services.xserver.enable;
    git.enable = true;
    gnupg.agent.enable = true;
  };
}
