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
    mbuffer -m 2048M | rage -R ${../../keys/nat.keys} -o - | mbuffer -m 2048M | swift upload --segment-size 1G -H "X-Delete-After: $EXPIRY" --object-name "$FILENAME" "$BUCKET" -
  '';
}
