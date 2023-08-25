{ config
, inputs
, ...
}: {
  imports = [
    inputs.impermanence.nixosModule
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixpkgs.nixosModules.notDetected
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.natwork
    inputs.self.nixosModules.virtualisation
    ./media.nix
    ./storage.nix
  ];

  # Hostname
  networking.hostName = "blahaj";

  # Bootloader/Kernel/Modules
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" "8821cu" ];
  };

  # PCIe Passthrough
  boot.extraModprobeConfig = "options vfio-pci ids=8086:0412,8086:8c20";

  # Power management
  boot.kernelParams = [ "intel_pstate=disable" ];
  powerManagement.cpuFreqGovernor = "performance";
  services.undervolt = {
    enable = true;
    coreOffset = -80;
    uncoreOffset = -170;
  };
}
