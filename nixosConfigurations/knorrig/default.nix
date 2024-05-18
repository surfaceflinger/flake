{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.self.nixosModules.laptop
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.natwork
    inputs.self.nixosModules.ryzen
    inputs.self.nixosModules.virtualisation
    ./storage.nix
  ];

  # Hostname
  networking.hostName = "knorrig";

  # Bootloader/Kernel/Modules
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];
}
