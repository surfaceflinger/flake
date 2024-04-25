{ inputs, ... }:
{
  imports = [
    ./amberol.nix
    ./easyeffects.nix
    ./gtk.nix
    inputs.schizofox.homeManagerModule
    ./mpv.nix
    ./schizofox.nix
  ];

  home.stateVersion = "24.05";
}
