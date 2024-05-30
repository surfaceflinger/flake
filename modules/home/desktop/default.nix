{ inputs, ... }:
{
  imports = [
    ./amberol.nix
    ./easyeffects.nix
    ./gtk.nix
    inputs.schizofox.homeManagerModule
    ./mangohud.nix
    ./mpv.nix
    ./schizofox.nix
    ./xdg.nix
  ];

  home.stateVersion = "24.05";
}
