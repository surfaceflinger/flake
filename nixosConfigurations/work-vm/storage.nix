{ ... }:
{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/disk/by-partuuid";
  networking.hostId = "e5ef2880";

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
    device = "work-vm/NixOS/nix";
    fsType = "zfs";
  };

  fileSystems."/etc/ssh" = {
    device = "work-vm/NixOS/etc/ssh";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "work-vm/NixOS/persist";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1A60-B111";
    fsType = "vfat";
  };
}
