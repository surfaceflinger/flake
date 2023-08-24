{ writeShellApplication
, rizin
, discord-canary
}:

writeShellApplication rec {
  name = "krisp-patch";

  runtimeInputs = [ rizin ];

  text = ''
    discord_version="${discord-canary.version}"
    file="$HOME/.config/discordcanary/$discord_version/modules/discord_krisp/discord_krisp.node"

    addr=$(rz-find -x '4889dfe8........4889dfe8' "$file" | head -n1)
    rizin -q -w -c "s $addr + 0x12 ; wao nop" "$file"
  '';
}
