{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.postBootCommands = lib.optionalString config.boot.zfs.enabled ''
    # to debug check: journalctl -b | grep stage-2-init
    echo Mounting all zfs filesystems
    ${pkgs.zfs}/bin/zfs mount -a
  '';
}
