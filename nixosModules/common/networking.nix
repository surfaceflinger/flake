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

  networking.networkmanager = {
    enable = config.services.xserver.enable;
    dns = lib.mkForce "none";
    wifi = {
      powersave = false;
      scanRandMacAddress = false;
    };
    extraConfig = ''
      [main]
      rc-manager=unmanaged
    '';
  };
  environment.persistence."/persist".directories = lib.mkIf (config.networking.networkmanager.enable && config.ephemereal) [ "/etc/NetworkManager/system-connections" ];
  hardware.usb-modeswitch.enable = config.networking.networkmanager.enable;

  services.avahi = {
    enable = config.services.xserver.enable;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  networking.useNetworkd = true;
  services.resolved = {
    enable = true;
    dnssec = "true";
    fallbackDns = [
      "1.0.0.1#cloudflare-dns.com"
      "1.1.1.1#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "8.8.4.4#dns.google"
      "8.8.8.8#dns.google"
      "2001:4860:4860::8844#dns.google"
      "2001:4860:4860::8888#dns.google"
      "9.9.9.11#dns11.quad9.net"
      "149.112.112.11#dns11.quad9.net"
      "2620:fe::11#dns11.quad9.net"
      "2620:fe::fe:11#dns11.quad9.net"
    ];
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
