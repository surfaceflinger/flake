{
  config,
  modulesPath,
  ...
}:
{
  imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];

  services = {
    qemuGuest.enable = true;
    spice-autorandr.enable = config.services.xserver.enable;
    spice-vdagentd.enable = config.services.xserver.enable;
    spice-webdavd.enable = config.services.xserver.enable;
  };
}
