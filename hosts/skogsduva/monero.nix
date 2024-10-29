_: {
  networking.firewall.allowedTCPPorts = [ 18080 ];

  services.monero = {
    enable = true;
    rpc = {
      address = "0.0.0.0";
      port = 18089;
      restricted = true;
    };
    limits = {
      download = 1024;
      upload = 1048576;
    };
    extraConfig = ''
      confirm-external-bind=1
      db-sync-mode=safe
      enforce-dns-checkpointing=1
      no-igd=1
      p2p-use-ipv6=1
      prune-blockchain=1
      rpc-bind-ipv6-address=::
      rpc-use-ipv6=1
    '';
  };
}
