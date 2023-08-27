_: {
  services.monero = {
    enable = true;
    rpc = {
      restricted = true;
      address = "0.0.0.0";
    };
    limits = {
      threads = 4;
      upload = 65536;
    };
    extraConfig = ''
      confirm-external-bind=true
      in-peers=1024
      limit-rate-down=524288
      limit-rate-up=524288
      no-igd=true
      out-peers=64
      prune-blockchain=true
      sync-pruned-blocks=true
    '';
  };
}
