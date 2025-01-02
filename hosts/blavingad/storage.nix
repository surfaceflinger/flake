_: {
  ephemeral = true;
  networking.hostId = "0f8a54ac";
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.devNodes = "/dev/disk/by-partuuid";
  };

  fileSystems."/boot" = {
    device = "/dev/vda1";
    fsType = "vfat";
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
    device = "blavingad/NixOS/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/etc/ssh" = {
    device = "blavingad/NixOS/etc/ssh";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/persist" = {
    device = "blavingad/NixOS/persist";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };
}
