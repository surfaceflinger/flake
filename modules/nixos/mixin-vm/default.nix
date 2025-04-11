{
  config,
  modulesPath,
  ...
}:
{
  imports = [ "${modulesPath}/profiles/qemu-guest.nix" ];

  services = {
    qemuGuest.enable = true;
    spice-autorandr.enable = config.isDesktop;
    spice-vdagentd.enable = config.isDesktop;
    spice-webdavd.enable = config.isDesktop;
  };
}
