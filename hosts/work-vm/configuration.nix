{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.mixin-tpm20
    inputs.self.nixosModules.mixin-vm
    inputs.self.nixosModules.user-natwork
    ./storage.nix
  ];

  # base
  networking.hostName = "work-vm";
  nixpkgs.hostPlatform = "x86_64-linux";

  # bootloader/kernel/modules
  boot.initrd.availableKernelModules = [
    "ahci"
    "sr_mod"
    "xhci_pci"
  ];

  users.users.natwork.extraGroups = [ "wheel" ];
}
