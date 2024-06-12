{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t440p
    inputs.self.nixosModules.laptop
    inputs.self.nixosModules.mixin-tpm12
    inputs.self.nixosModules.user-nat
    inputs.self.nixosModules.user-natwork
    ./storage.nix
  ];

  # base
  networking.hostName = "djungelskog";
  nixpkgs.hostPlatform = "x86_64-linux";

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
    coreOffset = -60;
    uncoreOffset = -200;
  };
}
