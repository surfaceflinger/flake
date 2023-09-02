{ pkgs, ... }: {
  services.unbound = {
    enable = true;
    enableRootTrustAnchor = true;
    resolveLocalQueries = false;
    package = pkgs.unbound-full;
    settings.server = {
      aggressive-nsec = true;
      cache-min-ttl = 300;
      deny-any = true;
      edns-buffer-size = 1232;
      fast-server-permil = 750;
      harden-algo-downgrade = true;
      harden-large-queries = true;
      harden-referral-path = true;
      hide-identity = true;
      hide-trustanchor = true;
      hide-version = true;
      infra-cache-slabs = 4;
      interface = "127.0.0.1";
      key-cache-slabs = 8;
      msg-cache-slabs = 8;
      neg-cache-size = "4m";
      num-queries-per-thread = 4096;
      num-threads = 4;
      outgoing-range = 8192;
      port = 5335;
      prefer-ip6 = true;
      prefetch-key = true;
      prefetch = true;
      qname-minimisation = true;
      rrset-cache-size = "8m";
      rrset-cache-slabs = 4;
      serve-expired = true;
      serve-expired-ttl = 86400;
      serve-expired-ttl-reset = true;
      so-rcvbuf = "4m";
      so-sndbuf = "4m";
      target-fetch-policy = "\"0 0 0 0 0\"";
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

  systemd.services.blocky = {
    after = [ "unbound.service" ];
    requires = [ "unbound.service" ];
  };

  services.blocky = {
    enable = true;
    settings = {
      bootstrapDns = [{ upstream = "127.0.0.1:5335"; }];
      ede.enable = true;
      ports.dns = [ "100.68.177.59:53" ];
      startVerifyUpstream = true;
      upstreams = {
        groups.default = [ "127.0.0.1:5335" ];
        timeout = "5s";
      };
      blocking = {
        clientGroupsBlock.default = [ "default" ];
        blackLists.default = [
          "https://adaway.org/hosts.txt"
          "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
          "https://gist.githubusercontent.com/surfaceflinger/f9cf0e5befabf5d36c07a66953d9954c/raw"
          "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
          "https://hole.cert.pl/domains/domains.txt"
          "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
          "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
          "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
          "https://phishing.army/download/phishing_army_blocklist_extended.txt"
          "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
          "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
          "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
          "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
          "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
          "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
          "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
          "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
          "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
          "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
          "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
          "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
          "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
          "https://urlhaus.abuse.ch/downloads/hostfile/"
          "https://v.firebog.net/hosts/AdguardDNS.txt"
          "https://v.firebog.net/hosts/Admiral.txt"
          "https://v.firebog.net/hosts/Easylist.txt"
          "https://v.firebog.net/hosts/Easyprivacy.txt"
          "https://v.firebog.net/hosts/Prigent-Ads.txt"
          "https://v.firebog.net/hosts/Prigent-Crypto.txt"
          "https://v.firebog.net/hosts/RPiList-Malware.txt"
          "https://v.firebog.net/hosts/RPiList-Phishing.txt"
          "https://v.firebog.net/hosts/static/w3kbl.txt"
          "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
        ];
        whiteLists.default = [
          "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/optional-list.txt"
          "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt"
        ];
      };
    };
  };

  boot.kernel.sysctl."net.core.rmem_max" = 4194304;
  boot.kernel.sysctl."net.core.wmem_max" = 4194304;
}
