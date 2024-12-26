# todo: switch to nix-mineral
_: {
  # fixup for building
  services.logrotate.checkConfig = false;

  # restrict nix users
  nix.settings.allowed-users = [
    "@wheel"
    "root"
  ];

  # block root login
  environment.etc = {
    securetty.text = "";
    machine-id.text = "b08dfa6083e7567a1921a715000001fb";
  };

  # restrict /boot access
  fileSystems."/boot".options = [ "umask=0077" ];

  security = {
    protectKernelImage = true;
    forcePageTableIsolation = true;
    virtualisation.flushL1DataCache = "always";
  };

  boot.consoleLogLevel = 0;
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;

    # prevent boot console kernel log information leaks
    "kernel.printk" = "3 3 3 3";

    # restrict ebpf memes
    "kernel.unprivileged_bpf_disabled" = 1;

    # disable asynchronous i/o for all processes.
    # https://forums.whonix.org/t/io-uring-security-vulnerabilties/16890/6
    "kernel.io_uring_disabled" = 2;

    # restrict loading tty line disciplines to the cap_sys_module capability to
    # prevent unprivileged attackers from loading vulnerable line disciplines with
    # the tiocsetd ioctl
    "dev.tty.ldisc_autoload" = 0;

    # the sysrq key exposes a lot of potentially dangerous debugging functionality
    # to unprivileged users
    "kernel.sysrq" = 0;

    # prevent creating files in potentially attacker-controlled environments such
    # as world-writable directories to make data spoofing attacks more difficult
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;

    # disable core dumps
    "fs.suid_dumpable" = 0;
    "kernel.core_pattern" = "|/bin/false";

    # oops/warns limit instead of panic
    "kernel.oops_limit" = 100;
    "kernel.warn_limit" = 100;
  };

  boot.kernelParams = [
    # enable full strict iommu
    "iommu=force"
    "efi=disable_early_pci_dma"

    # randomise page allocator freelists, improving security by making page allocations less predictable
    "page_alloc.shuffle=1"

    # these parameters prevent information leaks during boot and must be used
    # in combination with the kernel.printk
    "quiet"

    # why would you?
    "nohibernate"

    # disable direct writing to block devices if theyre mounted
    "bdev_allow_write_mounted=0"

    # kernel control flow integrity (wont work with gcc builds anyway)
    "cfi=kcfi"

    # more strict mitigations, disable smt if necessary
    "mitigations=auto,nosmt"

    # disable tsx extensions since theyre pmuch useless nowadays
    "tsx=off"
  ];

  boot.blacklistedKernelModules = [
    # disable thunderbolt and firewire modules to prevent some dma attacks
    "thunderbolt"
    "firewire-core"
    "firewire_core"
    "firewire-ohci"
    "firewire_ohci"
    "firewire_sbp2"
    "firewire-sbp2"
    "ohci1394"
    "sbp2"
    "dv1394"
    "raw1394"
    "video1394"

    # disables unneeded network protocols that will likely not be used as these may have unknown vulnerabilities.
    "dccp"
    "sctp"
    "rds"
    "tipc"
    "n-hdlc"
    "ax25"
    "netrom"
    "x25"
    "rose"
    "decnet"
    "econet"
    "af_802154"
    "ipx"
    "appletalk"
    "psnap"
    "p8023"
    "p8022"
    "can"
    "atm"

    # disable uncommon file systems to reduce attack surface
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"

    # disable uncommon network file systems to reduce attack surface
    "cifs"
    "nfs"
    "nfsv3"
    "nfsv4"
    "ksmbd"
    "gfs2"

    # disables the vivid kernel module as it's only required for testing and has been the cause of multiple vulnerabilities
    "vivid"

    # disable intel management engine (me) interface with the os
    "mei"
    "mei-me"

    # blacklist automatic loading of the atheros 5k rf macs madwifi driver
    "ath_pci"

    # blacklist automatic loading of miscellaneous modules
    "evbug"
    "usbmouse"
    "usbkbd"
    "eepro100"
    "de4x5"
    "eth1394"
    "snd_intel8x0m"
    "snd_aw2"
    "prism54"
    "bcm43xx"
    "garmin_gps"
    "asus_acpi"
    "snd_pcsp"
    "pcspkr"

    # blacklist automatic loading of framebuffer drivers
    "aty128fb"
    "atyfb"
    "radeonfb"
    "cirrusfb"
    "cyber2000fb"
    "cyblafb"
    "gx1fb"
    "hgafb"
    "i810fb"
    "intelfb"
    "kyrofb"
    "lxfb"
    "matroxfb_bases"
    "neofb"
    "nvidiafb"
    "pm2fb"
    "rivafb"
    "s1d13xxxfb"
    "savagefb"
    "sisfb"
    "sstfb"
    "tdfxfb"
    "tridentfb"
    "vesafb"
    "vfb"
    "viafb"
    "vt8623fb"
    "udlfb"
  ];
}
