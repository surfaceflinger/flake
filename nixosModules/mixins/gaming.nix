{ pkgs, ... }:
{
  boot.kernelParams = [
    # Remove artificial penalties for split locks, which is useful for games run
    # through Proton.
    # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
    "split_lock_detect=off"
  ];

  # packs
  environment.systemPackages = with pkgs; [
    jazz2 # I maintain this, ok?
    lunar-client # Minecraft with spyware
    mangohud # temps etc
    #pcsx2 # PS2 emu
    (prismlauncher.override {
      glfw = glfw-wayland-minecraft;
      jdks = [
        temurin-bin-8
        temurin-bin-21
      ];
    }) # Minecraft
    steamguard-cli # Steam MFA
    steamtinkerlaunch
  ];

  # Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # Controller rules
  hardware.steam-hardware.enable = true;
  services.udev.packages = with pkgs; [ game-devices-udev-rules ];
}
