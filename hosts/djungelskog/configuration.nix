{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t440p
    inputs.self.nixosModules.laptop
    inputs.self.nixosModules.mixin-gaming
    inputs.self.nixosModules.mixin-mitigations-off
    inputs.self.nixosModules.mixin-tpm12
    inputs.self.nixosModules.user-nat
    inputs.self.nixosModules.user-natwork
    ./storage.nix
  ];

  # base
  networking.hostName = "djungelskog";
  nixpkgs.hostPlatform = "x86_64-linux";

  # bootloader/kernel/modules
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "sr_mod"
      "rtsx_pci_sdmmc"
    ];
    kernelModules = [ "kvm-intel" ];
  };

  # power management
  boot.kernelParams = [ "intel_pstate=passive" ];
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
    CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
  };

  # thinkfan
  services = {
    thinkfan = {
      enable = true;
      levels = [
        [
          0
          0
          65
        ]
        [
          1
          65
          75
        ]
        [
          3
          75
          80
        ]
        [
          7
          80
          90
        ]
        [
          "level disengaged"
          90
          32767
        ]
      ];
      sensors = [
        {
          query = "/sys/devices/platform/coretemp.0/hwmon/";
          indices = [
            1
            2
            3
            4
            5
          ];
          type = "hwmon";
        }
      ];
    };
  };

  services.ollama.enable = true;

  # disable these fucking pgup/pgdown around arrow up - who came up with this?
  services.keyd = {
    enable = true;
    keyboards."liteon" = {
      ids = [ "0001:0001" ];
      settings.main = {
        pageup = "noop";
        pagedown = "noop";
      };
    };
  };
}
