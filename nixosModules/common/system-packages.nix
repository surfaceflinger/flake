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
    wget

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
  ] ++ lib.optionals config.services.xserver.enable [
    # Desktop software
    amberol
    gnome-feeds
    halloy
    vscode
    xfce.mousepad

    # Media
    krita
    (mpv.override { scripts = [ mpvScripts.inhibit-gnome mpvScripts.quality-menu mpvScripts.mpris ]; })
    yt-dlp
  ];

  programs = {
    adb.enable = config.services.xserver.enable;
    git.enable = true;
    gnupg.agent.enable = true;
  };
}
