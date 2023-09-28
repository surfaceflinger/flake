{ pkgs, config, ... }: {
  services.printing = {
    enable = true;
    webInterface = false;
    stateless = true;
  };

  # fix for resolving printers through mdns/avahi
  services.avahi.nssmdns = false;
  system.nssModules = with pkgs.lib; optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  system.nssDatabases.hosts = with pkgs.lib;
    optionals (!config.services.avahi.nssmdns) (mkMerge [
      (mkOrder 900 [ "mdns4_minimal [NOTFOUND=return]" ]) # must be before resolve
      (mkOrder 1501 [ "mdns4" ]) # 1501 to ensure it's after dns
    ]);
}
