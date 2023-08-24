_: {
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "blocky" ];
  networking.hostId = "0f8a54ac";

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/sda15";
    fsType = "vfat";
  };
}
