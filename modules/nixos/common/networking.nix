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

  # dns
  services.resolved = {
    enable = true;
    dnssec = "false"; # causes resolves to fail way too often
    llmnr = "false";
    fallbackDns = [
      "149.112.112.11#dns11.quad9.net"
      "2620:fe::11#dns11.quad9.net"
      "2620:fe::fe:11#dns11.quad9.net"
      "9.9.9.11#dns11.quad9.net"
    ];
    extraConfig = ''
      Cache=no-negative
      DNSOverTLS=opportunistic
      MulticastDNS=false
      StaleRetentionSec=28800
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
  };
}
