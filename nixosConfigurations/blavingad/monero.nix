_: {
  networking.firewall.allowedTCPPorts = [ 18080 ];

  services.monero = {
    enable = true;
    rpc = {
      restricted = true;
      port = 18089;
    };
    limits = {
      download = 524288;
      threads = 4;
      upload = 524288;
    };
    extraConfig = ''
      confirm-external-bind=true
      db-sync-mode=safe
      enforce-dns-checkpointing=1
      in-peers=1024
      no-igd=true
      out-peers=64
      p2p-bind-ip=0.0.0.0
      p2p-bind-ipv6-address=::
      p2p-bind-port=18080
      p2p-use-ipv6=true
      prune-blockchain=true
      rpc-bind-ipv6-address=::
      rpc-use-ipv6=true
      sync-pruned-blocks=true
    '';
  };
}
