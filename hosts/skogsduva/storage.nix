_: {
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "17c1a92a";

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
    device = "skogsduva/NixOS/nix";
    fsType = "zfs";
  };

  fileSystems."/etc/ssh" = {
    device = "skogsduva/NixOS/etc/ssh";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "skogsduva/NixOS/persist";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partuuid/dc5ef06b-ea2e-4c74-b108-bb09c0aefe9d";
    fsType = "vfat";
  };
}
