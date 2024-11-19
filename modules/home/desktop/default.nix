{ osConfig, ... }:
{
  imports = [
    ./amberol.nix
    ./easyeffects.nix
    ./gtk.nix
    ./mangohud.nix
    ./mpv.nix
    ./schizofox.nix
    ./xdg.nix
  ];

  home.stateVersion = osConfig.system.stateVersion;
}
