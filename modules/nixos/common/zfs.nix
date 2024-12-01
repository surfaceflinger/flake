{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.zfs.package = lib.warn "switch to stable zfs once 2.3.0 is out" pkgs.zfs_unstable;

  boot.postBootCommands = lib.optionalString config.boot.zfs.enabled ''
    # to debug check: journalctl -b | grep stage-2-init
    echo Mounting all zfs filesystems
    ${pkgs.zfs}/bin/zfs mount -a
  '';

  services.zfs = {
    autoScrub.interval = "*-*-10 02:00:00 Europe/Warsaw";
    trim = {
      enable = true;
      interval = "weekly";
    };
  };
}
