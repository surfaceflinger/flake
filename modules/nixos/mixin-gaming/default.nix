{ pkgs, ... }:
{
  boot.kernel.sysctl = {
    # remove artificial penalties for split locks, which is useful for games run
    # through proton.
    # https://www.phoronix.com/news/linux-splitlock-hurts-gaming
    "kernel.split_lock_mitigate" = 0;
  };

  # packs
  environment.systemPackages = with pkgs; [
    adwsteamgtk
    furmark # upalarnia pl
    jazz2 # I maintain this, ok?
    lunar-client # Minecraft with spyware
    pcsx2 # PS2 emu
    rpcs3 # ps3 emu
    steamguard-cli # Steam MFA
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk21
      ];
    }) # Minecraft
  ];

  # gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # steam
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    extraPackages = with pkgs; [
      steamtinkerlaunch
      winetricks
    ];
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
  };

  # controller rules
  services.udev.packages = with pkgs; [ game-devices-udev-rules ];
  hardware = {
    steam-hardware.enable = true;
    xone.enable = true;
  };
}
