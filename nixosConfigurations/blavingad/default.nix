{ config
, pkgs
, inputs
, modulesPath
, ...
}: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    ./adguard.nix
    ./storage.nix
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.server
    inputs.xkomhotshot.nixosModules.default
  ];

  # Hostname
  networking.hostName = "blavingad";

  # Bootloader/Kernel/Modules
  boot.initrd.availableKernelModules = [ "xhci_pci" "virtio_pci" "virtio_scsi" "usbhid" "sr_mod" ];

  # Other software
  environment.systemPackages = with pkgs; [ ArchiSteamFarm ];

  # xkom telegram bot
  age.secrets.xkomhotshot.file = ../../secrets/xkomhotshot.age;
  services.xkomhotshot = {
    enable = true;
    environmentFile = config.age.secrets.xkomhotshot.path;
  };
}
