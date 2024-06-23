_: {
  services.chrony = {
    enable = true;
    enableNTS = true;
    extraConfig = ''
      authselectmode prefer
      cmdport 0
      dscp 46
      leapsectz right/UTC
      makestep 1.0 3
      minsources 3
      nocerttimecheck 1
    '';
  };
  networking.timeServers = [
    # sorted by tlds to avoid
    # using multiple servers
    # from the same provider
    "ntp.nanosrvr.cloud"
    "ptbtime1.ptb.de"
    "www.masters-of-cloud.de"
    "nts.ntstime.de"
    "ntp3.fau.de"
    "ntp3.ipv6.fau.de"
    "www.jabber-germany.de"
    "time.bolha.one"
    "gbg1.nts.netnod.se"
    "ntp.trifence.ch"
    "time.signorini.ch"
    "ntppool1.time.nl"
    "paris.time.system76.com"
    "time.cloudflare.com"
    "time.txryan.com"
    "a.st1.ntp.br"
    "ntp.3eck.net"
    "ntp.zeitgitter.net"
    "ntp.miuku.net"
    "ntpmon.dcs1.biz"
    "stratum1.time.cifelli.xyz"
  ];
}
