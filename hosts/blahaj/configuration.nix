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
    inputs.self.nixosModules.mixin-gaming
    inputs.self.nixosModules.mixin-iwlwifi
    inputs.self.nixosModules.mixin-ryzen
    inputs.self.nixosModules.mixin-tpm20
    inputs.self.nixosModules.mixin-virtualisation
    inputs.self.nixosModules.user-nat
    ./media.nix
    ./storage.nix
  ];

  # base
  networking.hostName = "blahaj";
  nixpkgs.hostPlatform = "x86_64-linux";

  # bootloader/kernel/modules
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

  # need this for correct gpu work (capped at 220w tdp but it can use 280w)
  # also undervolt
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
  };

  # rx7800xt is still pretty much fucked in latest mainline and default 165hz is flickering
  boot.kernelParams = [ "video=2560x1440@144" ];

  # openrgb
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

  # obs with gstreamer and vkcapture
  environment.systemPackages = [
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-vkcapture
      ];
    })
    pkgs.obs-studio-plugins.obs-vkcapture
  ];
}
