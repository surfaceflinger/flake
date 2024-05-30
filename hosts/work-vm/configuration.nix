{
  inputs,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.mixin-ryzen
    inputs.self.nixosModules.mixin-tpm20
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
    "virtio_blk"
    "virtio_pci"
    "xhci_pci"
  ];
  services = {
    qemuGuest.enable = true;
    spice-autorandr.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
  };

  users.users.natwork.extraGroups = [
    "podman"
    "wheel"
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };

  environment.systemPackages = with pkgs; [ buildah ];
}
