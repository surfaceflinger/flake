{ config, pkgs, lib, ... }:
# Other useful settings come from srvos's zfs module
{
  config = lib.mkIf config.boot.zfs.enabled {
    boot.kernelParams = [ "init_on_alloc=0" "init_on_free=0" ];

    environment.systemPackages = [
      pkgs.zfs-prune-snapshots
    ];
  };
}
