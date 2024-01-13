{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nyx.nixosModules.steam-compat-tools
  ];

  # packs
  environment.systemPackages = with pkgs; [
    jazz2 # I maintain this, ok?
    lunar-client # Minecraft with spyware
    mangohud # temps etc
    pcsx2 # PS2 emu
    (prismlauncher.override { glfw = glfw-wayland-minecraft; }) # Minecraft
    steamguard-cli # Steam MFA
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
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };

  # Proton GE + luxtorpeda
  chaotic.steam.extraCompatPackages = with inputs.nyx.packages.${pkgs.system}; [
    luxtorpeda
    proton-ge-custom
  ];

  # Controller rules
  hardware.steam-hardware.enable = true;
  services.udev.packages = with pkgs; [ game-devices-udev-rules ];
}
