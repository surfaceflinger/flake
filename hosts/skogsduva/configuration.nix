{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    "${inputs.nixos-hardware}/common/cpu/intel/haswell"
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.self.nixosModules.mixin-tpm12
    inputs.self.nixosModules.mixin-virtualisation
    inputs.self.nixosModules.server
    inputs.self.nixosModules.user-nat
    ./monero.nix
    ./storage.nix
  ];

  # base
  networking.hostName = "skogsduva";
  nixpkgs.hostPlatform = "x86_64-linux";

  # bootloader/kernel/modules
  boot = {
    blacklistedKernelModules = [ "rtw88_8821cu" ];
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
    initrd.availableKernelModules = [
      "ahci"
      "ehci_pci"
      "sd_mod"
      "sr_mod"
      "usbhid"
      "usb_storage"
      "xhci_pci"
    ];
    kernelModules = [
      "8821cu"
      "kvm-intel"
    ];
  };

  # yes this is a server over wifi - inb4 dont use networkmanager on a server
  # and keep the password in agenix with systemd-networkd!!!!!!!!!!!!!!!!!! idc!!
  networking.networkmanager.enable = lib.mkForce true;

  # this is an old intel.
  boot.kernelParams = [ "intel_pstate=passive" ];
}
