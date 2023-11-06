{ config, ... }:
{
  age.secrets.vaultwarden.file = ../../secrets/vaultwarden.age;

  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets.vaultwarden.path;
    config = {
      SMTP_FROM_NAME = "nat's vaultwarden";
      INVITATION_ORG_NAME = "nat's vaultwarden";
      SIGNUPS_ALLOWED = false;
      INVITATIONS_ALLOWED = false;
      USER_ATTACHMENT_LIMIT = 1048576;
      ORG_ATTACHMENT_LIMIT = 1048576;
      PASSWORD_ITERATIONS = 600000;
      DOMAIN = "https://vault.nekopon.pl";
      EMERGENCY_ACCESS_ALLOWED = false;
      ROCKET_ADDRESS = "::1";
      ROCKET_PORT = 9500;
      PUSH_ENABLED = true;
      SMTP_HOST = "smtp.postmarkapp.com";
      SMTP_FROM = "root@vault.nekopon.pl";
      SMTP_SECURITY = "starttls";
      SMTP_PORT = 587;
    };
  };

  services.caddy.virtualHosts."vault.nekopon.pl".extraConfig = ''
    header {
      Strict-Transport-Security "max-age=31536000;"
      X-XSS-Protection "1; mode=block"
      X-Frame-Options "DENY"
      X-Robots-Tag "noindex, nofollow"
      X-Content-Type-Options "nosniff"
      -Server
      -X-Powered-By
      -Last-Modified
    }

    reverse_proxy [::1]:9500 { header_up X-Real-IP {remote_host} }
  '';
}
