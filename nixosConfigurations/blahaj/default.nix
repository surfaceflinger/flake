{ config
, inputs
, pkgs
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

  # Power management
  boot.kernelParams = [ "intel_pstate=disable" ];
  powerManagement.cpuFreqGovernor = "performance";
  services.undervolt = {
    enable = true;
    coreOffset = -80;
    uncoreOffset = -170;
  };


  # MERKUSYS wifi dongle workaround
  services.udev.extraRules = ''
    ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -K -v 0bda -p 1a2b"
  '';
}
