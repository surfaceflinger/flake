{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.zfs.autoSnapshot = {
    enable = true;
    flags = "-k -p -u -v";
    monthly = 2;
  };

  boot.postBootCommands = lib.optionalString config.boot.zfs.enabled ''
    # to debug check: journalctl -b | grep stage-2-init
    echo Mounting all zfs filesystems
    ${pkgs.zfs}/bin/zfs mount -a
  '';

  # fix unmounting /var/log (implicit zfs native mountpoint) on shutdown
  systemd.services.systemd-journal-flush = {
    before = [ "shutdown.target" ];
    conflicts = [ "shutdown.target" ];
  };
}
