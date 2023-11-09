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
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.hdr.enable = true;
  chaotic.mesa-git.enable	= true;
}
