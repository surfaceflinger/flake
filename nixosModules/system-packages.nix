{ config, lib, pkgs, ... }: {
  # Other software
  environment.systemPackages = with pkgs; [
    # CLI/TUI tools
    bat
    binwalk
    deadnix
    eza
    file
    magic-wormhole-rs
    nano
    ncdu
    nixpkgs-fmt
    p7zip
    rage
    ripgrep
    screen
    signify
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
    nmap
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
