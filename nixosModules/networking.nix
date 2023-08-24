{ config, ... }: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
  };

  networking.networkmanager = {
    enable = true;
    firewallBackend = "nftables";
    wifi.backend = "iwd";
  };

  services.tailscale.enable = true;
}
