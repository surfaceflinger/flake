_: {
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "b84cacfe";

  ephemereal = true;

  # i use the same passphrase for all zpools so let's import all of them at once
  # then execute zfs load-key -a and feed the passphrase to it with yes
  # otherwise i have to type the same (quite long) thing multiple times.
  #  boot.initrd.postdevicecommands = ''
  #    zpool import -a
  #    read -s -p "enter passphrase for zpools: " zfspassphrase
  #    yes "$zfspassphrase" | zfs load-key -a
  #    unset zfspassphrase
  #  '';

  boot.zfs.extraPools = [
    "smolhaj"
    "ikea"
  ];

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
    device = "blahaj/NixOS/nix";
    fsType = "zfs";
  };

  fileSystems."/etc/ssh" = {
    device = "blahaj/NixOS/etc/ssh";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "blahaj/NixOS/persist";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/blahajEFI";
    fsType = "vfat";
  };

  systemd.tmpfiles.rules = [ "d /vol/Games 0700 nat users - -" ];
}
