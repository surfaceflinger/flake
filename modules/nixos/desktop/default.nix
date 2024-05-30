{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./gnome.nix
    ./logitech.nix
    ./pipewire.nix
    ./printing.nix
  ];

  time.timeZone = "Europe/Warsaw";
  hardware.ledger.enable = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.plymouth.enable = true;
}
