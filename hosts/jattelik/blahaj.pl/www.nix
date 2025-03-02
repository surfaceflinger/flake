{ inputs, ... }:
{
  services.caddy.virtualHosts."blahaj.pl".extraConfig = ''
    root * ${inputs.blahajpl-homepage}
    file_server
  '';
}
