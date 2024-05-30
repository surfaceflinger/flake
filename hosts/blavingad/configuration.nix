{
  config,
  inputs,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
    ./gotosocial.nix
    inputs.self.nixosModules.user-nat
    inputs.self.nixosModules.vps
    inputs.srvos.nixosModules.mixins-cloud-init
    inputs.xkomhotshot.nixosModules.default
    ./matrix.nix
    ./microbin.nix
    ./monero.nix
    ./radicale.nix
    ./soju.nix
    ./storage.nix
    ./vaultwarden.nix
    ./www.nix
  ];
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sr_mod"
    "uhci_hcd"
    "virtio_blk"
    "virtio_pci"
  ];

  # base
  networking.hostName = "blavingad";
  nixpkgs.hostPlatform = "x86_64-linux";

  # networking
  services.cloud-init.enable = false;

  # netcup doesn't provide dhcp
  # and their metadata service bugs cloud-init out.
  systemd.network.networks."1-wan" = {
    matchConfig.Name = "ens3";
    address = [
      "2a03:4000:21:215::1/64"
      "94.16.120.239/22"
    ];
    routes = [
      { routeConfig.Gateway = "fe80::1"; }
      { routeConfig.Gateway = "94.16.120.1"; }
    ];
    # make the routes on this interface a dependency for network-online.target
    linkConfig.RequiredForOnline = "routable";
  };

  # xkom telegram bot
  services.xkomhotshot = {
    enable = true;
    environmentFile = config.age.secrets.xkomhotshot.path;
  };

  # tor snowflake proxy
  services.snowflake-proxy = {
    enable = true;
    capacity = 100;
  };

  # other software
  environment.systemPackages = with pkgs; [ ArchiSteamFarm ];

  # secrets
  age.secrets.googlebackup = {
    file = ../../secrets/googlebackup.age;
    mode = "500";
    owner = "nat";
  };
  age.secrets.xkomhotshot.file = ../../secrets/xkomhotshot.age;
}
