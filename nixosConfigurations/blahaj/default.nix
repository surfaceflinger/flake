{ config, inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.gaming
    inputs.self.nixosModules.iwlwifi
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
    zfs.enableUnstable = true;
    kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
  };

  # need this for correct gpu work (maxing out at 220W TDP so let's max out the power limit:3)
  # also undervolt
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
  };

  # rx7800xt is still pretty much fucked in latest mainline and default 165hz is flickering
  boot.kernelParams = [ "video=2560x1440@144" ];

  # OpenRGB
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # ollama
  services.ollama = {
    enable = true;
    package = pkgs.ollama.override { enableRocm = true; };
  };

  # OBS with GStreamer and vkcapture
  environment.systemPackages = [ (pkgs.wrapOBS { plugins = with pkgs.obs-studio-plugins; [ obs-vaapi obs-vkcapture ]; }) pkgs.obs-studio-plugins.obs-vkcapture ];

  # GNOME VRR
  # nixpkgs.overlays = [ inputs.coturnix.overlays.gnome-vrr ];

  # Fixup volume
  environment.etc."wireplumber/main.lua.d/80-blahaj.lua".text = ''
    table.insert (alsa_monitor.rules, {
      matches = {
        {
          { "device.name", "matches", "alsa_card.usb-Superlux_digit_Superlux_E205U-00" },
        },
      },
      apply_properties = {
        ["api.alsa.soft-mixer"] = true,
      },
    })
  '';
}
