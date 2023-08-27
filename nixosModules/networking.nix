{ config, lib, ... }: {
  imports = [ ./hetzner.nix ];

  systemd.network.networks."10-eth-dhcp" = lib.mkIf (!config.modules.hetzner.wan.enable) {
    matchConfig.Type = "ether";
    networkConfig = {
      DHCP = "yes";
      IPv6AcceptRA = true;
      IPForward = "yes";
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}
