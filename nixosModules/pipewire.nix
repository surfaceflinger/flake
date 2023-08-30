_: {
  hardware.pulseaudio.enable = false;
  environment.etc."wireplumber/main.lua.d/99-resample.lua".text = ''
    table.insert (alsa_monitor.rules, {
      matches = {
        {
          { "node.name", "matches", "alsa_input.*" },
        },
        {
          { "node.name", "matches", "alsa_output.*" },
        },
      },
      apply_properties = {
        ["resample.quality"] = 10,
      },
    })
  '';
}
