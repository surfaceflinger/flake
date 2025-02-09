let
  host-blavingad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDA6kIVhyu6xav3zsUP2UFbr4MWOKnn0rYkYqf1eQ8wx";
  host-skogsduva = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFC2wynlCNvuMdeXAGp0ce1gds3SXJgy/7cRINFK1bR";
  user-nat-blahaj = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIACA/8h6byidHxDaO0kMWHdKYYpPwRW1nrVPOZr90YiW";
in
{
  "xkomhotshot.age".publicKeys = [
    host-skogsduva
    user-nat-blahaj
  ];
  "googlebackup.age".publicKeys = [
    host-blavingad
    user-nat-blahaj
  ];
  "vaultwarden.age".publicKeys = [
    host-blavingad
    user-nat-blahaj
  ];
}
