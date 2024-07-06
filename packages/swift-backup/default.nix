{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "swift-backup";

  runtimeInputs = [
    pkgs.mbuffer
    pkgs.rage
    pkgs.swiftclient
  ];

  text = ''
    FILENAME="$(date +'%Y-%m-%d_%H-%M-%S').age"
    mbuffer -m 512M | rage -R ${../../keys/nat.keys} -o - | mbuffer -m 512M | swift upload --segment-size 1G -H "X-Delete-After: $EXPIRY" --object-name "$FILENAME" "$BUCKET" -
  '';
}
