{
  config,
  lib,
  pkgs,
  ...
}:
{
  # enable dhcp on all physical ethernet interfaces
  systemd.network.networks."10-eth-dhcp" =
    lib.mkIf (!(config.services.cloud-init.enable && config.services.cloud-init.network.enable))
      {
        # match every ether type
        matchConfig.Type = "ether";
        # these are usually managed by vpns, hypervisors etc.
        matchConfig.Driver = "!tun";
        matchConfig.Name = "!veth* !vnet*";
        # enable dhcp and routing
        networkConfig = {
          DHCP = true;
          IPv4Forwarding = true;
          IPv6Forwarding = true;
          IPv6PrivacyExtensions = "kernel";
        };
      };

  # desktop networking
  networking.networkmanager = {
    inherit (config.services.xserver) enable;
    wifi.backend = "iwd";
  };
  environment.persistence."/persist".directories = lib.mkIf (
    config.networking.networkmanager.enable && config.ephemereal
  ) [ "/etc/NetworkManager/system-connections" ];
  hardware.usb-modeswitch.enable = config.networking.networkmanager.enable;

  # mdns
  services.avahi = {
    inherit (config.services.xserver) enable;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # dns
  services.resolved = {
    enable = true;
    llmnr = "false";
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
    extraConfig = ''
      MulticastDNS=false
      DNSOverTLS=opportunistic
    '';
  };

  # tailscale
  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both";
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  ## https://github.com/tailscale/tailscale/issues/8223
  systemd.services."whytailscalewhy" = {
    description = "Tailscale restart on resume";
    wantedBy = [ "post-resume.target" ];
    after = [ "post-resume.target" ];
    script = ''
      . /etc/profile;
      ${pkgs.systemd}/bin/systemctl restart tailscaled.service
    '';
    serviceConfig.Type = "oneshot";
  };

  # kernel tuning
  boot.kernel.sysctl = {
    # bbr + CAKE
    "net.core.default_qdisc" = lib.mkForce "cake";
    "net.ipv4.tcp_congestion_control" = lib.mkForce "bbr";

    # nonlocal bind, helps some "race conditions" with services hosted on vpns etc.
    "net.ipv4.ip_nonlocal_bind" = 1;
    "net.ipv6.ip_nonlocal_bind" = 1;

    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_fin_timeout" = 10;
    "net.ipv4.tcp_slow_start_after_idle" = 0;

    "net.ipv4.tcp_keepalive_time" = 60;
    "net.ipv4.tcp_keepalive_intvl" = 10;
    "net.ipv4.tcp_keepalive_probes" = 6;

    # mtu probing
    "net.ipv4.tcp_mtu_probing" = 1;

    ## a martian packet is a one with a source address which is blatantly wrong
    ## recommended to keep a log of these to identify these suspicious packets
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.default.log_martians" = 1;

    # prevent syn flood attacks
    "net.ipv4.tcp_syncookies" = 1;

    # protect against time-wait assassination by dropping rst packets for sockets
    # in the time-wait state
    "net.ipv4.tcp_rfc1337" = 1;

    # packet source validation
    "net.ipv4.conf.default.rp_filter" = 1;

    # disable accepting icmp redirects
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # disable icmp redirect sending
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    # ignore bogus icmp error responses
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

    # disable source routing
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.default.accept_source_route" = 0;

    # disable accepting ipv6 router advertisements
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv6.default.accept_ra" = 0;

    # ipv6 privacy extensions
    "net.ipv6.conf.all.use_tempaddr" = 2;

    # disable tcp sack. sack is commonly exploited and unnecessary for many
    # circumstances so it should be disabled if you don't require it
    "net.ipv4.tcp_sack" = 0;
    "net.ipv4.tcp_dsack" = 0;
    "net.ipv4.tcp_fack" = 0;

    # avoid leaking system time with tcp timestamps
    "net.ipv4.tcp_timestamps" = 0;
  };
}
