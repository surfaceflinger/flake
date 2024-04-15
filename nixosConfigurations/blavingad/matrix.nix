{
  config,
  inputs,
  pkgs,
  ...
}:
let
  server_name = "nekopon.pl";
  matrix_hostname = "matrix.${server_name}";

  conf = {
    default_server_config = {
      "m.homeserver" = {
        base_url = "https://${matrix_hostname}:443";
        inherit server_name;
      };
    };
    show_labs_settings = true;
  };
in
{
  services.matrix-conduit = {
    enable = true;
    package = inputs.conduit.packages.${pkgs.system}.default;
    settings.global = {
      inherit server_name;
      # rocksdb
      database_backend = "rocksdb";
      db_cache_capacity_mb = 1024;
      rocksdb_bottommost_compression = true;

      # Compression
      brotli_compression = true;
      gzip_compression = true;
      zstd_compression = true;

      # Misc
      allow_device_name_federation = true;
      allow_public_room_directory_over_federation = true;
      max_concurrent_requests = 1000;
      new_user_displayname_suffix = "";
      sentry = true;

      trusted_servers = [
        "grapheneos.org"
        "matrix.org"
        "monero.social"
        "nerdsin.space"
        "nixos.dev"
        "nixos.org"
      ];
    };
  };

  services.caddy.virtualHosts."${server_name}".extraConfig = ''
    handle_path /.well-known/matrix/* {
      respond /server `{"m.server": "${matrix_hostname}:443"}`
      respond /client `{"m.homeserver": {"base_url": "https://${matrix_hostname}"}, "org.matrix.msc3575.proxy": {"url": "https://${matrix_hostname}"}}`
    }
  '';

  services.caddy.virtualHosts."${matrix_hostname}".extraConfig = ''
    redir / https://${server_name}
    reverse_proxy [::1]:${toString config.services.matrix-conduit.settings.global.port}
  '';
}
