{ lib
, pkgs
, config
, ...
}:
{
  services.printing = {
    enable = true;
    webInterface = false;
    stateless = true;
  };

  # fix for resolving printers through mdns/avahi
  system.nssModules = lib.optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  system.nssDatabases.hosts =
    with lib;
    optionals (!config.services.avahi.nssmdns) (
      mkMerge [
        (mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
        (mkAfter [ "mdns4" ]) # after dns
      ]
    );
}
