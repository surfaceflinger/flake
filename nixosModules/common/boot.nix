{ config, lib, ... }:
let
  hasEfi = (config.fileSystems."/boot".fsType or "") == "vfat";
in
{
  # Bootloader
  boot.loader = {
    # The number of seconds for user intervention before the default boot option is selected.
    timeout = lib.mkDefault 3;
    efi.canTouchEfiVariables = lib.mkForce false;
    grub = {
      enable = lib.mkDefault (!hasEfi);
      efiSupport = lib.mkDefault false;
      device = "nodev";
      fsIdentifier = "label";
    };
    systemd-boot = {
      enable = lib.mkDefault hasEfi;
      # The resolution of the console. A higher resolution displays more entries.
      consoleMode = "max";
    };
  };

  # Enable all firmware
  hardware.enableAllFirmware = true;
}
