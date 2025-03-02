_: {
  services.soju = {
    enable = true;
    adminSocket.enable = true;
    listen = [ "irc+insecure://:6667" ];
  };
}
