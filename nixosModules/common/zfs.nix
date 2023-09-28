{ config, lib, ... }:
# Other useful settings come from srvos's zfs module
{
  boot.kernelParams = lib.optionals config.boot.zfs.enabled [ "init_on_alloc=0" "init_on_free=0" ];
}
