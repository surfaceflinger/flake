{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./geolocation.nix
    ./gnome.nix
    ./logitech.nix
    ./pipewire.nix
    ./printing.nix
  ];

  time.timeZone = "Europe/Warsaw";
}
