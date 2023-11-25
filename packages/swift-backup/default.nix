{ writeShellApplication
, python-swiftclient
, rage
}:

writeShellApplication {
  name = "swift-backup";

  runtimeInputs = [ python-swiftclient rage ];

  text = ''
    FILENAME="$(date +'%Y-%m-%d_%H-%M-%S').age"
    rage -r "$AGE_PUBLIC_KEY" -R ${../../nixosModules/users/nat.keys} -o - | swift upload --segment-size 1G -H "X-Delete-After: $EXPIRY" --object-name "$FILENAME" "$BUCKET" -
  '';
}
