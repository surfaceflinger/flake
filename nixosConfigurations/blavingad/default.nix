{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    inputs.self.nixosModules.nat
    inputs.self.nixosModules.vps
    inputs.srvos.nixosModules.hardware-hetzner-cloud-arm
    inputs.xkomhotshot.nixosModules.default
    ./dns.nix
    ./matrix.nix
    ./microbin.nix
    ./monero.nix
    ./soju.nix
    ./storage.nix
    ./vaultwarden.nix
    ./www.nix
  ];

  # Networking
  networking.hostName = "blavingad";

  # Other software
  environment.systemPackages = with pkgs; [ ArchiSteamFarm ];

  # xkom telegram bot
  age.secrets.xkomhotshot.file = ../../secrets/xkomhotshot.age;
  services.xkomhotshot = {
    enable = true;
    environmentFile = config.age.secrets.xkomhotshot.path;
  };

  # swift secret
  age.secrets.googlebackup = {
    file = ../../secrets/googlebackup.age;
    mode = "500";
    owner = "nat";
  };

  # TOR Snowflake proxy
  services.snowflake-proxy = {
    enable = true;
    capacity = 100;
  };
}
