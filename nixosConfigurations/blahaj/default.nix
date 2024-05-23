{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./audio.nix
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.gaming
    inputs.self.nixosModules.iwlwifi
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.ryzen
    inputs.self.nixosModules.tpm20
    inputs.self.nixosModules.virtualisation
    ./media.nix
    ./storage.nix
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
    zfs.package = pkgs.zfs_unstable;
    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
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
  services.hardware.openrgb.enable = true;

  # ollama
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables.HSA_OVERRIDE_GFX_VERSION = "11.0.0";
  };

  # harmonia binary cache
  networking.firewall.allowedTCPPorts = [ 30909 ];
  services.harmonia = {
    enable = true;
    settings = {
      bind = "[::]:30909";
    };
  };

  # OBS with GStreamer and vkcapture
  environment.systemPackages = [
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-vkcapture
      ];
    })
    pkgs.obs-studio-plugins.obs-vkcapture
  ];

  # Higher framerate in QEMU
  nixpkgs.overlays = with pkgs; [
    (_self: super: {
      qemu_kvm = super.qemu_kvm.overrideAttrs (oldAttrs: {
        postPatch =
          oldAttrs.postPatch
          + ''
            sed -i 's/GUI_REFRESH_INTERVAL_DEFAULT    30/GUI_REFRESH_INTERVAL_DEFAULT 13/g' include/ui/console.h
          '';
      });
    })
  ];
}
