{ config, inputs, lib, ... }: {
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
  hardware.usb-modeswitch.enable = true;
  hardware.ledger.enable = true;
}
