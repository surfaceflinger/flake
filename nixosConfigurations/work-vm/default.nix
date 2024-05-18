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
    inputs.self.nixosModules.natwork
    inputs.self.nixosModules.tpm20
    ./storage.nix
  ];

  # Hostname
  networking.hostName = "work-vm";

  # Bootloader/Kernel/Modules
  boot.initrd.availableKernelModules = [
    "ahci"
    "sr_mod"
    "virtio_blk"
    "virtio_pci"
    "xhci_pci"
  ];
  boot.kernelModules = [ "kvm-amd" ];
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
