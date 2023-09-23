{ inputs, pkgs, ... }: {
  imports = [
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./chromium.nix
    ./common.nix
    ./gnome.nix
    ./logitech.nix
    ./mitigations-off.nix
    ./pipewire.nix
    ./printing.nix
    ./steam.nix
  ];

  time.timeZone = "Europe/Warsaw";
  hardware.ledger.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
}
