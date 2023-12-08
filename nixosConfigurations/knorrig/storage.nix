{ ... }:
{
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "b897eda4";

  ephemereal = true;

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
