{ config, inputs, pkgs, ... }:
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
      database_backend = "rocksdb";
      allow_registration = false;
      trusted_servers = [ "matrix.org" "nixos.org" "nixos.dev" "monero.social" "grapheneos.org" "nerdsin.space" "midov.pl" ];
      enable_lightning_bolt = false;
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

  services.caddy.virtualHosts."element.${server_name}".extraConfig = ''
    header {
      Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
      X-Content-Type-Options "nosniff"
      Referrer-Policy "no-referrer"
      Cross-Origin-Opener-Policy "same-origin"
      Cross-Origin-Embedder-Policy "require-corp"
      Origin-Agent-Cluster "?1"
      Permissions-Policy "interest-cohort=()"
      Cross-Origin-Resource-Policy "cross-origin"
      Content-Security-Policy "font-src 'self'; manifest-src 'self'; object-src 'none'; script-src 'self' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; frame-ancestors 'self'"
      X-Frame-Options "SAMEORIGIN"
      X-Robots-Tag "none"
    }

    file_server { root ${pkgs.element-web.override { inherit conf; }} }
  '';
}
