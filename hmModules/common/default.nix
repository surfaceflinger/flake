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
      ./gtk.nix
      ./easyeffects.nix
      ./mpv.nix
    ];

  home.stateVersion = "24.05";
}
