# blahaj.

## create encrypted pool with stripe:

```
zpool create -f \
  -O acltype=posixacl \
  -o ashift=13 \
  -O atime=off \
  -o autotrim=on \
  -O canmount=off \
  -O checksum=blake3 \
  -O compression=lz4 \
  -O devices=off \
  -O dnodesize=auto \
  -O encryption=aes-256-gcm \
  -O keyformat=passphrase \
  -O keylocation=prompt \
  -O mountpoint=none \
  -O normalization=formD \
  -O xattr=sa \
  -R /mnt \
  blahaj \
  /dev/disk/by-id/ata-CT250MX500SSD1_2141E5D95F83-part2 /dev/disk/by-id/ata-CT250MX500SSD1_2141E5D95F96
```

## create datasets which are going to persist directories.

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

## permissions

`systemd-tmpfiles` is used to declaratively enforce owners and permission bits. (`storage.nix` + `media.nix` use it.)
