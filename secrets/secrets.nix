let
  host-blavingad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDA6kIVhyu6xav3zsUP2UFbr4MWOKnn0rYkYqf1eQ8wx";
  user-nat-blahaj = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcOe5wgtrprr3PtIq2w8PWveAGuP6y+p4yd0FxU7x8P";
in
{
  "xkomhotshot.age".publicKeys = [
    host-blavingad
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
