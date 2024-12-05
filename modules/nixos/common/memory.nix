{ pkgs, ... }:
{
  # https://github.com/pop-os/default-settings/blob/041cd94158142d6a34d2e684c847ac239a5ba086/etc/sysctl.d/10-pop-default-settings.conf
  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };

  boot.kernel.sysctl = {
    "vm.dirty_background_bytes" = 134217728;
    "vm.dirty_bytes" = 268435456;
    "vm.max_map_count" = 2147483642;
    "vm.page-cluster" = 0;
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };

  # thrashing prevention
  systemd.services."mglru" = {
    enable = true;
    wantedBy = [ "basic.target" ];
    script = "${pkgs.coreutils}/bin/echo 1000 > /sys/kernel/mm/lru_gen/min_ttl_ms";
    serviceConfig.Type = "oneshot";
    unitConfig.ConditionPathExists = "/sys/kernel/mm/lru_gen/enabled";
  };
}
