{ config, inputs, lib, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  # vms don't need firmware unless for gpu passthrough
  hardware.enableAllFirmware = lib.mkForce false;

  services = {
    qemuGuest.enable = true;
    spice-autorandr.enable = config.services.xserver.enable;
    spice-vdagentd.enable = config.services.xserver.enable;
    spice-webdavd.enable = config.services.xserver.enable;
  };
}
