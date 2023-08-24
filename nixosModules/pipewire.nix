_: {
  hardware.pulseaudio.enable = false;
  environment.etc."wireplumber/main.lua.d/99-nat.lua".text = ''
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

    table.insert (alsa_monitor.rules, {
      matches = {
        {
          { "device.name", "matches", "alsa_card.*" },
        },
      },
      apply_properties = {
        ["api.alsa.soft-mixer"] = true,
      },
    })
  '';
}
