_: {
  users.users.nat.extraGroups = [ "ipfs" ];

  services.kubo = {
    enable = true;
    localDiscovery = false;
    enableGC = true;
    settings = {
      Adresses.API = [ ];
      Discovery.MDNS.Enabled = false;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 4001 ];
    allowedUDPPorts = [ 4001 ];
  };
}
