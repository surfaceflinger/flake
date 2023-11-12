{ config
, inputs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixpkgs.nixosModules.notDetected
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
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" "8821cu" ];
  };

  # Power management
  boot.kernelParams = [ "intel_pstate=active" ];
  services.undervolt = {
    enable = true;
    coreOffset = -80;
    uncoreOffset = -170;
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
