_: {
  services.unbound = {
    enable = true;
    enableRootTrustAnchor = true;
    resolveLocalQueries = false;
    settings.server = {
      do-ip4 = true;
      do-ip6 = true;
      edns-buffer-size = 1232;
      harden-dnssec-stripped = true;
      harden-glue = true;
      interface = "127.0.0.1";
      num-threads = 2;
      port = 5335;
      prefer-ip6 = false;
      prefetch = true;
      qname-minimisation = true;
      so-rcvbuf = "1m";
      use-caps-for-id = false;
      verbosity = 0;
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

  services.blocky = {
    enable = true;
    settings = {
      bootstrapDns = [{ upstream = "127.0.0.1"; }];
      ede.enable = true;
      ports.dns = [ "100.68.177.59:53" ];
      startVerifyUpstream = true;
      upstream.default = [ "127.0.0.1:5335" ];
      upstreamTimeout = "5s";
      blocking = {
        clientGroupsBlock.default = [ "default" ];
        blackLists.default = [
          "https://adaway.org/hosts.txt"
          "https://gist.githubusercontent.com/surfaceflinger/f9cf0e5befabf5d36c07a66953d9954c/raw"
          "https://hole.cert.pl/domains/domains.txt"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
        ];
      };
    };
  };

  boot.kernel.sysctl."net.core.rmem_max" = 1048576;
}
