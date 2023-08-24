{ config, ... }: {
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      inotify = "yes";
      media_dir = [ "V,/vol/ikea/Media/Videos/" ];
      friendly_name = config.networking.hostName;
    };
  };

  services.darkhttpd = {
    enable = true;
    port = 9090;
    address = "all";
    rootDir = "/vol/ikea/Media/Videos/";
  };
  networking.firewall.allowedTCPPorts = [ config.services.darkhttpd.port ];

  # Allow both darkhttpd and minidlna to see media files.
  systemd.tmpfiles.rules = [
    "d /vol/ikea 0755 nat root - -"
    "d /vol/ikea/Media 0755 nat root - -"
    "d /vol/ikea/Media/Videos 0755 nat root - -"
  ];

}
