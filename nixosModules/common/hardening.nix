{ ... }:
{
  # Fixup for building
  services.logrotate.checkConfig = false;

  # Restrict Nix users
  nix.settings.allowed-users = [
    "@wheel"
    "root"
  ];

  # jitterentropy
  boot.initrd.kernelModules = [ "jitterentropy_rng" ];
  services.jitterentropy-rngd.enable = true;

  # Block root login
  environment.etc.securetty.text = "";

  # Restrict /boot access
  fileSystems."/boot".options = [ "umask=0077" ];

  security.protectKernelImage = true;
  boot.consoleLogLevel = 0;
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;

    # CAP_SYSLOG
    "kernel.dmesg_restrict" = 1;

    # Prevent boot console kernel log information leaks
    "kernel.printk" = "3 3 3 3";

    # Restrict eBPF memes
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;

    # Restrict loading TTY line disciplines to the CAP_SYS_MODULE capability to
    # prevent unprivileged attackers from loading vulnerable line disciplines with
    # the TIOCSETD ioctl
    "dev.tty.ldisc_autoload" = 0;

    # Restrict userfaultfd()
    "vm.unprivileged_userfaultfd" = 0;

    # CAP_PERFMON
    "kernel.perf_event_paranoid" = 3;

    # The SysRq key exposes a lot of potentially dangerous debugging functionality
    # to unprivileged users
    "kernel.sysrq" = 0;

    # Restrict usage of ptrace to only processes with the CAP_SYS_PTRACE
    # capability
    "kernel.yama.ptrace_scope" = 1;

    # Increase bits of entropy used for mmap ASLR
    "vm.mmap_rnd_bits" = 32;
    "vm.mmap_rnd_compat_bits" = 16;

    # Permit symlinks to be followed when outside of a world-writable sticky directory,
    # when the owner of the symlink and follower match or when the directory owner
    # matches the symlink's owner. This also prevents hardlinks from being created
    # by users that do not have read/write access to the source file.
    "fs.protected_symlinks" = 1;
    "fs.protected_hardlinks" = 1;

    # Prevent creating files in potentially attacker-controlled environments such
    # as world-writable directories to make data spoofing attacks more difficult
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;

    # Disable core dumps
    "syskernel.core_pattern" = "|/bin/false";
    "fs.suid_dumpable" = 0;

    # Disable legacy TIOCSTI
    "dev.tty.legacy_tiocsti" = 0;
  };

  boot.kernelParams = [
    # Enable full strict iommu
    "amd_iommu=force_isolation"
    "intel_iommu=on"
    "iommu=force"
    "iommu.passthrough=0"
    "iommu.strict=1"
    "efi=disable_early_pci_dma"

    # Disable slab merging which significantly increases the difficulty of heap
    # exploitation by preventing overwriting objects from merged caches and by
    # making it harder to influence slab cache layout
    "slab_nomerge"

    # Zeroing of memory during allocation and free time
    "init_on_alloc=1"
    "init_on_free=1"

    # Randomise page allocator freelists, improving security by making page allocations less predictable
    "page_alloc.shuffle=1"

    # Randomise the kernel stack offset on each syscall
    "randomize_kstack_offset=on"

    # Disable vsyscalls as they are obsolete and have been replaced with vDSO.
    # vsyscalls are also at fixed addresses in memory, making them a potential
    # target for ROP attacks
    "vsyscall=none"

    # Disable debugfs which exposes a lot of sensitive information about the
    # kernel
    "debugfs=off"

    # Sometimes certain kernel exploits will cause what is known as an "oops".
    # This parameter will cause the kernel to panic on such oopses, thereby
    # preventing those exploits
    "oops=panic"

    # Panic on uncorrectable errors in ECC memory
    "mce=0"

    # These parameters prevent information leaks during boot and must be used
    # in combination with the kernel.printk
    "quiet"

    # Disable CPU RDRAND and random seed sourced from bootloader
    "random.trust_cpu=off"
    "random.trust_bootloader=off"

    # Why would you?
    "nohibernate"

    # Whonix machine-id
    "systemd.machine_id=b08dfa6083e7567a1921a715000001fb"

    # We're waiting for complete Secure Boot support in nixpkgs :)
    # "lockdown=confidentiality";
    # "module.sig_enforce=1";
  ];

  boot.blacklistedKernelModules = [
    # Obscure networking protocols
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
    # Various rare filesystems
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "udf"
    "cifs"
    "nfs"
    "nfsv3"
    "nfsv4"
    "ksmbd"
    "gfs2"
    # vivid driver is only useful for testing purposes and has been the cause
    # of privilege escalation vulnerabilities
    "vivid"
    # Disable FireWire and Thunderbolt to prevent DMA attacks
    "firewire-core"
    "thunderbolt"
  ];
}
