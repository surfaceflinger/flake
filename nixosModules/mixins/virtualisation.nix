{ config, pkgs, ... }:
{
  environment.systemPackages =
    with pkgs; lib.optionals config.services.xserver.enable [ virt-manager ];

  virtualisation = {
    spiceUSBRedirection.enable = config.services.xserver.enable;
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = false;
        ovmf.enable = true;
      };
    };
  };

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';

  boot.kernelModules = [
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
    "vfio_virqfd"
  ];
}
