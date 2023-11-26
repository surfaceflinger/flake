{ lib, pkgs, ... }:
{
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "b897eda4";

  ephemereal = true;

  zramSwap.writebackDevice = "/dev/zvol/knorrig/zramwriteback";
  systemd.services.zramwriteback-enable =
    let
      script = pkgs.writeScript "zramwriteback-enable" ''
        #!${lib.getExe pkgs.bash}
        echo all > /sys/block/zram0/idle
        echo idle > /sys/block/zram0/writeback
      '';
    in
    {
      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-zram-setup@zram0.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
    };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=2G"
      "mode=755"
    ];
  };

  fileSystems."/nix" = {
    device = "knorrig/NixOS/nix";
    fsType = "zfs";
  };

  fileSystems."/etc/ssh" = {
    device = "knorrig/NixOS/etc/ssh";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "knorrig/NixOS/persist";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5230-BEF0";
    fsType = "vfat";
  };
}
