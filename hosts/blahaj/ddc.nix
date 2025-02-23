{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];

  systemd.services.display-manager.script = lib.mkBefore ''
    # create the ddcci device for the monitor
    # this has to be done in this order
    echo 'ddcci 0x37' | tee /sys/class/drm/card*-DP-*/i2c-*/new_device && sleep 2
    ${pkgs.kmod}/bin/modprobe ddcci_backlight
  '';
}
