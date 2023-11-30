{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.postBootCommands = lib.optionalString (config.boot.zfs.enabled) ''
    # To debug check: journalctrl -b | grep stage-2-init
    echo Mounting all zfs filesystems
    ${pkgs.zfs}/bin/zfs mount -a
  '';
}
