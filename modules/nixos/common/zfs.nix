{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.zfs.package = pkgs.zfs_unstable;

  boot.kernelParams = [
    "zfs.metaslab_lba_weighting_enabled=0"
    "zfs.zfs_abd_scatter_enabled=0"
  ];

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
