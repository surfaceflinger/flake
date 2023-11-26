{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ steamguard-cli ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
