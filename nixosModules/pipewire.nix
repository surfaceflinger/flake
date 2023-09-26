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
        "pipewire"
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

  environment.etc = rtprioConf // resampleQualityConf;
}
