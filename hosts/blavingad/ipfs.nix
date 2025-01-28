_: {
  users.users.nat.extraGroups = [ "ipfs" ];

  services.kubo = {
    enable = true;
    localDiscovery = false;
    enableGC = true;
    settings = {
      Adresses.API = [ ];
      AutoTLS.Enabled = false;
      Discovery.MDNS.Enabled = false;
      Routing.AcceleratedDHTClient = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 4001 ];
    allowedUDPPorts = [ 4001 ];
  };
}
