{ inputs, pkgs, ... }: {
  imports = [
    inputs.self.nixosModules.common
    inputs.self.nixosModules.mitigations-off
    inputs.srvos.nixosModules.desktop
    ./bluetooth.nix
    ./chromium.nix
    ./gnome.nix
    ./logitech.nix
    ./pipewire.nix
    ./printing.nix
    ./steam.nix
  ];

  time.timeZone = "Europe/Warsaw";
  hardware.ledger.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
}
