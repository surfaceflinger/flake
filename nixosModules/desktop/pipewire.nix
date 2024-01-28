{ lib, ... }:
let
  resampleQualityConf = builtins.listToAttrs (
    builtins.map
      (
        n:
        lib.nameValuePair "pipewire/${n}.conf.d/resample-quality.conf" {
          text = builtins.toJSON { "stream.properties"."resample.quality" = 10; };
        }
      )
      [
        "client-rt"
        "client"
        "jack"
        "pipewire-pulse"
        "pipewire"
      ]
  );
in
{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.etc = resampleQualityConf;
}
