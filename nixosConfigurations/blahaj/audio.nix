{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];

  services.pipewire = {
    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
    extraConfig.pipewire."99-lowlatency".context.stream.properties.resample.quality = lib.mkForce 10;
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/main.lua.d/99-e205u.lua" ''
        table.insert(alsa_monitor.rules, {
            matches = {
                {
                    { "device.name", "matches", "alsa_card.usb-Superlux_digit_Superlux_E205U-00" },
                },
            },
            apply_properties = {
                ["api.alsa.soft-mixer"] = true,
            },
        })
      '')
    ];
  };
}
