_: {
  # fixup for building
  services.logrotate.checkConfig = false;

  # restrict nix users
  nix.settings.allowed-users = [
    "@wheel"
    "root"
  ];

  # jitterentropy
  boot.initrd.kernelModules = [ "jitterentropy_rng" ];
  services.jitterentropy-rngd.enable = true;

  # block root login
  environment.etc.securetty.text = "";

  # restrict /boot access
  fileSystems."/boot".options = [ "umask=0077" ];

  security.protectKernelImage = true;
  boot.consoleLogLevel = 0;
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;

    # cap_syslog
    "kernel.dmesg_restrict" = 1;

    # prevent boot console kernel log information leaks
    "kernel.printk" = "3 3 3 3";

    # restrict ebpf memes
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;

    # disable asynchronous i/o for all processes.
    # https://forums.whonix.org/t/io-uring-security-vulnerabilties/16890/6
    "kernel.io_uring_disabled" = 2;

    # restrict loading tty line disciplines to the cap_sys_module capability to
    # prevent unprivileged attackers from loading vulnerable line disciplines with
    # the tiocsetd ioctl
    "dev.tty.ldisc_autoload" = 0;

    # restrict userfaultfd()
    "vm.unprivileged_userfaultfd" = 0;

    # cap_perfmon
    "kernel.perf_event_paranoid" = 3;

    # the sysrq key exposes a lot of potentially dangerous debugging functionality
    # to unprivileged users
    "kernel.sysrq" = 0;

    # restrict usage of ptrace to only processes with the cap_sys_ptrace
    # capability
    "kernel.yama.ptrace_scope" = 1;

    # increase bits of entropy used for mmap aslr
    "vm.mmap_rnd_bits" = 32;
    "vm.mmap_rnd_compat_bits" = 16;

    # permit symlinks to be followed when outside of a world-writable sticky directory,
    # when the owner of the symlink and follower match or when the directory owner
    # matches the symlink's owner. this also prevents hardlinks from being created
    # by users that do not have read/write access to the source file.
    "fs.protected_symlinks" = 1;
    "fs.protected_hardlinks" = 1;

    # prevent creating files in potentially attacker-controlled environments such
    # as world-writable directories to make data spoofing attacks more difficult
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;

    # disable core dumps
    "fs.suid_dumpable" = 0;
    "kernel.core_uses_pid" = 1;
    "kernel.core_pattern" = "|/bin/false";

    # disable legacy tiocsti
    "dev.tty.legacy_tiocsti" = 0;
  };

  boot.kernelParams = [
    # enable full strict iommu
    "amd_iommu=force_isolation"
    "intel_iommu=on"
    "iommu=force"
    "iommu.passthrough=0"
    "iommu.strict=1"
    "efi=disable_early_pci_dma"

    # disable slab merging which significantly increases the difficulty of heap
    # exploitation by preventing overwriting objects from merged caches and by
    # making it harder to influence slab cache layout
    "slab_nomerge"

    # zeroing of memory during allocation and free time
    "init_on_alloc=1"
    "init_on_free=1"

    # randomise page allocator freelists, improving security by making page allocations less predictable
    "page_alloc.shuffle=1"

    # randomise the kernel stack offset on each syscall
    "randomize_kstack_offset=on"

    # disable vsyscalls as they are obsolete and have been replaced with vdso.
    # vsyscalls are also at fixed addresses in memory, making them a potential
    # target for rop attacks
    "vsyscall=none"

    # sometimes certain kernel exploits will cause what is known as an "oops".
    # this parameter will cause the kernel to panic on such oopses, thereby
    # preventing those exploits
    "oops=panic"

    # these parameters prevent information leaks during boot and must be used
    # in combination with the kernel.printk
    "quiet"

    # disable cpu rdrand and random seed sourced from bootloader
    "random.trust_cpu=off"
    "random.trust_bootloader=off"

    # why would you?
    "nohibernate"

    # whonix machine-id
    "systemd.machine_id=b08dfa6083e7567a1921a715000001fb"

    # we're waiting for complete secure boot support in nixpkgs :)
    # "lockdown=confidentiality";
    # "module.sig_enforce=1";
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
