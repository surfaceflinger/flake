# sauce: https://github.com/xddxdd/nixos-config/blob/master/nixos/client-components/pipewire.nix
{ inputs, lib, pkgs, ... }:
  let
  rtprioConf = builtins.listToAttrs (
    builtins.map
      (n:
        lib.nameValuePair "pipewire/${n}.conf.d/rtprio.conf" {
          text = builtins.toJSON {
            "context.modules" = [
              {
                name = "libpipewire-module-rt";
                args = {
                  "nice.level" = -11;
                  "rt.prio" = 88;
                  "rt.time.soft" = realtimeLimitUS;
                  "rt.time.hard" = realtimeLimitUS;
                };
                flags = [ "ifexists" "nofail" ];
              }
            ];
          };
        })
      [
        "client-rt"
        "client"
        "jack"
        "pipewire-pulse"
        "pipewire"
      ]
  );

  resampleQualityConf = builtins.listToAttrs (
    builtins.map
      (n:
        lib.nameValuePair "pipewire/${n}.conf.d/resample-quality.conf" {
          text = builtins.toJSON {
            "stream.properties"."resample.quality" = 10;
          };
        })
      [
        "client-rt"
        "client"
        "jack"
        "pipewire-pulse"
      ]
  );
  realtimeLimitUS = 5000000;
  in {

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  systemd.services.rtkit-daemon.serviceConfig.ExecStart = [
    "" # Override command in rtkit package's service file
    "${pkgs.rtkit}/libexec/rtkit-daemon --rttime-usec-max=${builtins.toString realtimeLimitUS}"
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.etc =
    rtprioConf
    // resampleQualityConf
    // {
      "pipewire/pipewire.conf.d/noise-cancelling.conf".text = builtins.toJSON {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.name" = "rnnoise_source";
              "node.description" = "Noise Canceling source";
              "media.name" = "Noise Canceling source";
              "filter.graph" = {
                nodes = [
                  {
                    type = "ladspa";
                    name = "rnnoise";
                    plugin = "${inputs.self.packages.${pkgs.system}.noise-suppression-for-voice}/lib/ladspa/librnnoise_ladspa.so";
                    label = "noise_suppressor_stereo";
                    control = {
                      "VAD Threshold (%)" = 50.0;
                    };
                  }
                ];
              };
              "capture.props" = {
                "node.passive" = true;
              };
              "playback.props" = {
                "media.class" = "Audio/Source";
              };
            };
          }
        ];
      };

      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
        	["bluez5.enable-sbc-xq"] = true,
        	["bluez5.enable-msbc"] = true,
        	["bluez5.enable-hw-volume"] = true,
        	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
}
