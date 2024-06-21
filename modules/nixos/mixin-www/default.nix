_: {
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };

  services.caddy = {
    enable = true;
    email = "ssl@nekopon.pl";
  };
}
