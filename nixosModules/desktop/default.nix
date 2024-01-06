{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./chromium.nix
    ./gnome.nix
    ./logitech.nix
    ./pipewire.nix
    ./printing.nix
  ];

  time.timeZone = "Europe/Warsaw";
  hardware.ledger.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_6;
}
