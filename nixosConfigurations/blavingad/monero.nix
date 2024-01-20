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
      download = 1048576;
      syncSize = 500;
      threads = 4;
      upload = 1048576;
    };
    extraConfig = ''
      confirm-external-bind=true
      db-sync-mode=safe
      enforce-dns-checkpointing=1
      in-peers=1024
      no-igd=true
      out-peers=128
      p2p-use-ipv6=true
      prune-blockchain=true
      rpc-bind-ipv6-address=::
      rpc-use-ipv6=true
      sync-pruned-blocks=true
    '';
  };
}
