{ pkgs, ... }:
{
  # 2FA
  environment.systemPackages = with pkgs; [ steamguard-cli ];

  # Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };

  # Controller rules
  hardware.steam-hardware.enable = true;
  services.udev.packages = with pkgs; [ game-devices-udev-rules ];
}
