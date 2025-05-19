{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./gnome.nix
    ./logitech.nix
    ./networking.nix
    ./pipewire.nix
    ./printing.nix
    ./system-packages.nix
    ./unharden.nix
  ];

  isDesktop = true;
  time.timeZone = "Europe/Warsaw";
  location.provider = "geoclue2";
}
