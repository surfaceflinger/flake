_: {
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "0f8a54ac";

  ephemereal = true;

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" "mode=755" ];
  };

  fileSystems."/nix" = {
    device = "blavingad/NixOS/nix";
    fsType = "zfs";
  };

  fileSystems."/etc/ssh" = {
    device = "blavingad/NixOS/etc/ssh";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "blavingad/NixOS/persist";
    fsType = "zfs";
  };
}
