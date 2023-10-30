let
  host-blavingad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDA6kIVhyu6xav3zsUP2UFbr4MWOKnn0rYkYqf1eQ8wx";
  user-nat-blahaj = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGeYYGkVH8pPo1f769OHYn6Vga6wnhftJA6w2IJADzgs";
in
{
  "xkomhotshot.age".publicKeys = [ host-blavingad user-nat-blahaj ];
  "googlebackup.age".publicKeys = [ host-blavingad user-nat-blahaj ];
  "vaultwarden.age".publicKeys = [ host-blavingad user-nat-blahaj ];
}
