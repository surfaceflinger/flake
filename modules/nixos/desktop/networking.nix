{
  config,
  lib,
  ...
}:
{
  # desktop networking
  networking.networkmanager.enable = true;
  hardware.usb-modeswitch.enable = true;

  environment.persistence."/persist".directories = lib.mkIf config.ephemereal [
    "/etc/NetworkManager/system-connections"
  ];

  # mdns
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
