{ config, lib, ... }:
let
  hasEfi = (config.fileSystems."/boot".fsType or "") == "vfat";
in
{
  # bootloader
  boot.loader = {
    # the number of seconds for user intervention before the default boot option is selected.
    timeout = lib.mkDefault 3;
    efi.canTouchEfiVariables = lib.mkForce false;
    grub = {
      enable = lib.mkDefault (!hasEfi);
      efiSupport = lib.mkDefault false;
      device = lib.mkDefault "nodev";
      fsIdentifier = "label";
    };
    systemd-boot = {
      enable = lib.mkDefault hasEfi;
      # the resolution of the console. a higher resolution displays more entries.
      consoleMode = "max";
    };
  };

  # enable all firmware
  hardware.enableAllFirmware = true;
}
