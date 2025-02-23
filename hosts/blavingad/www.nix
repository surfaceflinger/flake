{ inputs, ... }:
{
  services.caddy = {
    virtualHosts."natalia.ovh".extraConfig = "redir https://nekopon.pl";
    virtualHosts."nekopon.pl".extraConfig = ''
      route {
        header Content-Security-Policy "default-src 'self'; font-src fonts.gstatic.com; style-src 'self' fonts.googleapis.com; object-src 'none'"
        rewrite * /nekopon.pl{uri}
        reverse_proxy https://surfaceflinger.github.io { header_up Host {upstream_hostport} }
      }
    '';

    virtualHosts."blahaj.pl".extraConfig = ''
      root * ${inputs.blahajpl-homepage}
      file_server
    '';
  };
}
