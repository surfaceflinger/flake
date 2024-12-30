{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./geolocation.nix
    ./gnome.nix
    ./logitech.nix
    ./networking.nix
    ./pipewire.nix
    ./printing.nix
    ./system-packages.nix
  ];

  time.timeZone = "Europe/Warsaw";
}
