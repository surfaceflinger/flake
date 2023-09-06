{ writeShellApplication
, python-swiftclient
, rage
}:

writeShellApplication rec {
  name = "swift-backup";

  runtimeInputs = [ python-swiftclient rage ];

  text = ''
    FILENAME="$(date +'%Y-%m-%d_%H-%M-%S').age"
    rage -r "$AGE_PUBLIC_KEY" -o - | swift upload --segment-size 1G -H "X-Delete-After: $EXPIRY" --object-name "$FILENAME" "$BUCKET" -
  '';
}
