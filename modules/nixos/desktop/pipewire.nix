_: {
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    alsa.support32Bit = true;
    jack.enable = true;
    wireplumber.extraConfig."10-disable-camera"."wireplumber.profiles".main."monitor.libcamera" =
      "disabled";
  };
}
