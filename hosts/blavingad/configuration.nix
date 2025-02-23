{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./gotosocial.nix
    inputs.self.nixosModules.mixin-vm
    inputs.self.nixosModules.mixin-www
    inputs.self.nixosModules.server
    inputs.self.nixosModules.user-nat
    inputs.srvos.nixosModules.mixins-cloud-init
    ./ipfs.nix
    ./matrix.nix
    ./soju.nix
    ./storage.nix
    ./vaultwarden.nix
    ./wastebin.nix
    ./www.nix
  ];
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sr_mod"
    "uhci_hcd"
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
      { Gateway = "fe80::1"; }
      { Gateway = "94.16.120.1"; }
    ];
    # lldp doesn't work on e1000
    networkConfig.LLDP = false;
    # make the routes on this interface a dependency for network-online.target
    linkConfig.RequiredForOnline = "routable";
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
}
