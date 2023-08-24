# Blahaj.

## Create encrypted pool with stripe:

```
zpool create -f \
  -o ashift=12 \
  -o autotrim=on \
  -O acltype=posixacl \
  -O relatime=on \
  -O xattr=sa \
  -O dnodesize=auto \
  -O normalization=formD \
  -O utf8only=on \
  -O devices=off \
  -O compression=lz4 \
  -O encryption=aes-256-gcm \
  -O keyformat=passphrase \
  -O keylocation=prompt \
  -R /mnt \
  -O mountpoint=none \
  blahaj \
  /dev/disk/by-id/ata-CT250MX500SSD1_2141E5D95F83-part2 /dev/disk/by-id/ata-CT250MX500SSD1_2141E5D95F96
```

## Create datasets which are going to persist directories.

```
zfs create -o canmount=off -o mountpoint=/ blahaj/NixOS
zfs create -o canmount=off                 blahaj/NixOS/etc
zfs create -o canmount=on                  blahaj/NixOS/etc/nixos
zfs create -o canmount=on                  blahaj/NixOS/home
zfs create -o canmount=on                  blahaj/NixOS/nix
zfs create -o canmount=on                  blahaj/NixOS/persist
zfs create -o canmount=off                 blahaj/NixOS/var
zfs create -o canmount=on                  blahaj/NixOS/var/lib
zfs create -o canmount=on                  blahaj/NixOS/var/log
zfs create -o canmount=on                  blahaj/NixOS/vol/Games
```

## Permissions

`systemd-tmpfiles` is used to declaratively enforce owners and permission bits. (`storage.nix` + `media.nix` use it.)
