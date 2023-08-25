{ inputs, ... }: {
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
    ./waydroid.nix
  ];

  networking.networkmanager = {
    enable = true;
    firewallBackend = "nftables";
    wifi.backend = "iwd";
  };
  hardware.usb-modeswitch.enable = true;

  networking.wireless.iwd.settings.General.AddressRandomization = "disabled";

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
