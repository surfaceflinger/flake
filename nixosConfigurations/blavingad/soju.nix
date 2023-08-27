_: {
  services.soju = {
    enable = true;
    listen = [
      "irc+insecure://:6667"
      "unix+admin:///run/soju/admin"
    ];
  };
  systemd.services.soju.serviceConfig.RuntimeDirectory = "soju";
}
