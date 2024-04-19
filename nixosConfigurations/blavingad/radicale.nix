_:
let
  int_addy = "[::1]:5232";
in
{
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ int_addy ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = toString ./htpasswd.radicale;
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  };

  services.caddy.virtualHosts."radicale.nekopon.pl".extraConfig = ''
    reverse_proxy ${int_addy}
  '';
}
