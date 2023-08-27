{ config
, pkgs
, inputs
, modulesPath
, ...
}: {
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    ./dns.nix
    ./monero.nix
    ./soju.nix
    ./storage.nix
    ./www.nix
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.server
    inputs.xkomhotshot.nixosModules.default
  ];

  # Networking
  networking.hostName = "blavingad";
  modules.hetzner.wan = {
    enable = true;
    macAddress = "96:00:02:7c:6d:9f";
    ipAddresses = [
      "168.119.98.244/32"
      "2a01:4f8:c013:37::1/64"
    ];
  };

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
