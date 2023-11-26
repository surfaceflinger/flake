{
  config,
  lib,
  pkgs,
  ...
}:
{
  system.activationScripts.zfsAccurateHoleReporting = {
    text = "";
    deps = [ ];
  };

  boot.postBootCommands = lib.optionalString (config.boot.zfs.enabled) ''
    # To debug check: journalctrl -b | grep stage-2-init
    echo Mounting all zfs filesystems
    ${pkgs.zfs}/bin/zfs mount -a
    echo Applying workaround for ZFS corruption bug #15526
    echo 0 > /sys/module/zfs/parameters/zfs_dmu_offset_next_sync
  '';
}
