{ config, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.virtualisation
    ./storage.nix
    ./media.nix
  ];

  # Hostname
  networking.hostName = "blahaj";

  # Bootloader/Kernel/Modules
  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "usbhid"
      "xhci_pci"
    ];
    kernelModules = [
      "kvm-amd"
    ];
  };

  # GPU OC
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
  };

  # OpenRGB
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # Fixup volume
  environment.etc."wireplumber/main.lua.d/80-blahaj.lua".text = ''
    table.insert (alsa_monitor.rules, {
      matches = {
        {
          { "device.name", "matches", "alsa_card.*" },
        },
      },
      apply_properties = {
        ["api.alsa.soft-mixer"] = true,
      },
    })
  '';
}
