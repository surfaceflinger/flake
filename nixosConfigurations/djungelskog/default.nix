{ inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t440p
    inputs.nixpkgs.nixosModules.notDetected
    inputs.self.nixosModules.impermanence
    inputs.self.nixosModules.laptop
    inputs.self.nixosModules.nat
    ./storage.nix
  ];

  # Hostname
  networking.hostName = "djungelskog";

  # Bootloader/Kernel/Modules
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" "cpufreq_schedutil" "cpufreq_conservative" ];
  };

  # Power management
  boot = {
    kernelParams = [ "intel_pstate=disable" ];
    extraModprobeConfig = ''
      options iwlwifi power_save=1 uapsd_disable=1
      options snd_hda_intel power_save=1
      options usbcore autosuspend=1
    '';
  };
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
    CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
  };
  services.undervolt = {
    enable = true;
    coreOffset = -90;
    gpuOffset = -80;
    uncoreOffset = -250;
  };

  # Disable camera
  boot.blacklistedKernelModules = [ "uvcvideo" ];
}
