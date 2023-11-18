_: {
  services.chrony = {
    enable = true;
    enableNTS = true;
    extraConfig = ''
      authselectmode require
      cmdport 0
      dscp 46
      leapsectz right/UTC
      makestep 1.0 3
      minsources 2
    '';
  };
  networking.timeServers = [
    "time.cloudflare.com"
    "virginia.time.system76.com"
    "ptbtime1.ptb.de"
    "ntppool1.time.nl"
    "ntp.3eck.net"
    "ntp.trifence.ch"
    "ntp.zeitgitter.net"
  ];
}
