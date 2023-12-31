{ config
, lib
, pkgs
, ...
}:
{
  boot.kernelParams = [
    "zfs.metaslab_lba_weighting_enabled=0"
    "zfs.zfs_abd_scatter_enabled=0"
  ];

  boot.postBootCommands = lib.optionalString (config.boot.zfs.enabled) ''
    # To debug check: journalctrl -b | grep stage-2-init
    echo Mounting all zfs filesystems
    ${pkgs.zfs}/bin/zfs mount -a
  '';

  boot.zfs.removeLinuxDRM = pkgs.hostPlatform.isAarch64;
}
