{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t440p
    inputs.self.nixosModules.laptop
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.natwork
    ./storage.nix
  ];

  # Hostname
  networking.hostName = "djungelskog";

  # Bootloader/Kernel/Modules
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "sr_mod"
      "rtsx_pci_sdmmc"
    ];
    kernelModules = [ "kvm-intel" ];
  };

  # Power management
  boot.kernelParams = [ "intel_pstate=active" ];
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  };
  services.undervolt = {
    enable = true;
    coreOffset = -90;
    gpuOffset = -80;
    uncoreOffset = -250;
  };
}
