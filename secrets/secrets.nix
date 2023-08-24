let
  host-blavingad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILBVjZCmGUF26O4sQmdPv6IHA4hquDHrgQGoCSsflIT6";
  user-nat-blahaj = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGeYYGkVH8pPo1f769OHYn6Vga6wnhftJA6w2IJADzgs";
in
{
  "xkomhotshot.age".publicKeys = [ host-blavingad user-nat-blahaj ];
}
