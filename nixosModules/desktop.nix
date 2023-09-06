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

  networking.networkmanager.enable = true;
  environment.persistence."/persist".directories = lib.mkIf config.ephemereal.enable [ "/etc/NetworkManager/system-connections" ];
  hardware.usb-modeswitch.enable = true;

  hardware.ledger.enable = true;

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
