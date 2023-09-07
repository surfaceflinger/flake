{ config, lib, ... }: {
  imports = [ ./hetzner.nix ];

  systemd.network.networks."10-eth-dhcp" = lib.mkIf (!config.modules.hetzner.wan.enable) {
    # Match every ether type
    matchConfig.Type = "ether";
    # These are usually managed by VPNs, Hypervisors etc.
    matchConfig.Driver = "!tun";
    matchConfig.Name = "!veth* !vnet*";
    # Enable DHCP and RA
    networkConfig = {
      DHCP = "yes";
      IPv6AcceptRA = true;
      IPForward = "yes";
    };
  };

  networking.firewall = {
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
