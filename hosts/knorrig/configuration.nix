{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.self.nixosModules.laptop
    inputs.self.nixosModules.mixin-gaming
    inputs.self.nixosModules.mixin-ryzen
    inputs.self.nixosModules.mixin-tpm20
    inputs.self.nixosModules.mixin-virtualisation
    inputs.self.nixosModules.user-nat
    inputs.self.nixosModules.user-natwork
    ./storage.nix
  ];

  # base
  networking.hostName = "knorrig";
  nixpkgs.hostPlatform = "x86_64-linux";

  # bootloader/kernel/modules
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
}
