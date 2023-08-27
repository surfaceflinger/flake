_: {
  services.monero = {
    enable = true;
    rpc = {
      restricted = true;
      address = "0.0.0.0";
    };
    limits = {
      download = 524288;
      threads = 4;
      upload = 524288;
    };
    extraConfig = ''
      confirm-external-bind=true
      in-peers=1024
      no-igd=true
      out-peers=64
      prune-blockchain=true
      sync-pruned-blocks=true
    '';
  };
}
