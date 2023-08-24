_: {
  services.quassel = {
    enable = true;
    interfaces = [ "0.0.0.0" ];
  };
  systemd.services.quassel.after = [ "network-online.target" ];
}
