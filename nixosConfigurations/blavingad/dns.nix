{ ... }:
{
  services.unbound = {
    enable = true;
    enableRootTrustAnchor = true;
    resolveLocalQueries = false;
    settings.forward-zone = [{
      name = ".";
      forward-tls-upstream = true;
      forward-addr = [
        "194.242.2.4@853#base.dns.mullvad.net"
        "2a07:e340::4@853#base.dns.mullvad.net"
      ];
    }];
    settings.server = {
      deny-any = true;
      ede-serve-expired = true;
      ede = true;
      edns-tcp-keepalive = true;
      harden-algo-downgrade = true;
      harden-referral-path = true;
      hide-identity = true;
      hide-trustanchor = true;
      hide-version = true;
      infra-cache-numhosts = 100000;
      infra-cache-slabs = 8;
      ip-transparent = true;
      key-cache-slabs = 8;
      msg-cache-slabs = 8;
      neg-cache-size = "128m";
      num-queries-per-thread = 4096;
      num-threads = 4;
      outgoing-range = 32768;
      prefer-ip6 = true;
      prefetch-key = true;
      prefetch = true;
      rrset-cache-size = "256m";
      rrset-cache-slabs = 8;
      so-rcvbuf = "16m";
      so-sndbuf = "16m";
      tls-upstream = true;
      unwanted-reply-threshold = 10000000;
      interface = [
        "lo"
        "tailscale0"
      ];
      access-control = [
        "100.64.0.0/10 allow"
        "fd7a:115c:a1e0:ab12::/64 allow"
      ];
      private-address = [
        "10.0.0.0/8"
        "100.64.0.0/10"
        "169.254.0.0/16"
        "172.16.0.0/12"
        "192.168.0.0/16"
        "fd00::/8"
        "fd7a:115c:a1e0:ab12::/64"
        "fe80::/10"
      ];
    };
  };
}
