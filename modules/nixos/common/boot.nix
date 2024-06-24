{ config, lib, ... }:
{
  # bootloader
  boot.loader = {
    timeout = 3;
    efi.canTouchEfiVariables = lib.mkForce false;
    grub = {
      enable = true;
      device = lib.mkDefault "nodev";
      efiInstallAsRemovable = true;
      efiSupport = true;
      fsIdentifier = "label";
    };
    systemd-boot.enable = lib.mkForce false;
  };

  # enable all firmware
  hardware.enableAllFirmware = true;
}
