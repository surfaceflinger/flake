{
  inputs,
  lib,
  osConfig,
  ...
}:
{
  imports =
    [
      ./git.nix
      inputs.nix-index-database.hmModules.nix-index
      ./nix.nix
    ]
    ++ lib.optionals osConfig.services.xserver.enable [
      ./amberol.nix
      ./easyeffects.nix
      ./gtk.nix
      inputs.schizofox.homeManagerModule
      ./mpv.nix
      ./schizofox.nix
    ];

  home.stateVersion = "24.05";
}
