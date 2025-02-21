{ pkgs, ... }:
{
  # other software
  environment.systemPackages = with pkgs; [
    # desktop software
    buffer
    gnome-obfuscate
    lorem
    papers

    # media
    krita
    yt-dlp

    # system utilities
    glxinfo
    libva-utils
    (nvtopPackages.full.override { nvidia = false; })
    pavucontrol
  ];

  programs = {
    adb.enable = true;
  };
}
