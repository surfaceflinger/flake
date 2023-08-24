{ config, lib, pkgs, ... }: {
  # Other software
  environment.systemPackages = with pkgs; [
    # CLI/TUI tools
    binwalk
    deadnix
    file
    magic-wormhole-rs
    nano
    ncdu
    nixpkgs-fmt
    p7zip
    ripgrep
    screen
    tree
    wget

    # System utilities
    config.boot.kernelPackages.cpupower
    hyfetch
    lm_sensors
    pciutils
    psmisc
    usbutils

    # Networking
    bind
    nload
    whois
  ] ++ lib.optionals config.services.xserver.enable [
    # Desktop software
    burpsuite
    gnome-feeds
    halloy
    pavucontrol
    tor-browser-bundle-bin
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
    htop.enable = true;
    gnupg.agent.enable = true;
  };
}
