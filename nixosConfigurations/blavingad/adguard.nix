{ lib, ... }: {
  services.resolved.enable = false;

  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    settings = {
      bind_host = lib.mkForce "0.0.0.0";
      users = [
        {
          name = "nat";
          password = "$2a$10$uReUx/0kpqiya/DnTS51ZeN1h5UBXQroKxl3UrPnMl/xdq1.EllL2";
        }
      ];
      dns = {
        port = 53;
        bind_host = "0.0.0.0";
        enable_dnssec = true;
        ratelimit = 0;
        statistics_interval = 0;
        querylog_enabled = false;
        bootstrap_dns = [
          "9.9.9.10"
          "149.112.112.10"
          "2620:fe::10"
          "2620:fe::fe:10"
        ];
        upstream_dns = [
          "https://dns10.quad9.net/dns-query"
        ];
      };
      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
          id = 1;
        }
        {
          enabled = true;
          url = "https://adaway.org/hosts.txt";
          id = 2;
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/GameConsoleAdblockList.txt";
          id = 3;
        }
        {
          enabled = true;
          url = "https://hole.cert.pl/domains/domains.txt";
          id = 4;
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          id = 5;
        }
        {
          enabled = true;
          url = "https://gist.githubusercontent.com/surfaceflinger/f9cf0e5befabf5d36c07a66953d9954c/raw";
          id = 6;
        }
      ];
    };
  };
}
