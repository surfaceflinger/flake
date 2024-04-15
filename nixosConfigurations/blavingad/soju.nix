_: {
  services.soju = {
    enable = true;
    hostName = "soylent";
    listen = [ "irc+insecure://:6667" ];
  };
}
