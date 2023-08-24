{ config
, pkgs
, inputs
, modulesPath
, lib
, ...
}: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    inputs.agenix.nixosModules.default
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.server
    inputs.xkomhotshot.nixosModules.default
    ./storage.nix
    ./adguard.nix
    ./quassel.nix
  ];

  # Hostname
  networking.hostName = "blavingad";

  # Bootloader/Kernel/Modules
  boot = {
    loader.systemd-boot.configurationLimit = lib.mkForce 1;
    initrd = {
      availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" ];
      kernelModules = [ "nvme" ];
    };
  };

  # Other software
  environment.systemPackages = with pkgs; [ ArchiSteamFarm ];

  # xkom telegram bot
  age.secrets.xkomhotshot.file = ../../secrets/xkomhotshot.age;
  services.xkomhotshot = {
    enable = true;
    environmentFile = config.age.secrets.xkomhotshot.path;
  };

  # workaround NixOS/nix#8502
  services.logrotate.checkConfig = false;
}
