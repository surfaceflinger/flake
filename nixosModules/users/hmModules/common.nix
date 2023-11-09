{ inputs, lib, osConfig, ... }: {
  imports = [
    inputs.chaotic.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    ./nix.nix
  ] ++ lib.optionals osConfig.services.xserver.enable [
    ./dconf.nix
    ./easyeffects.nix
    ./mpv.nix
  ];

  home.stateVersion = "22.11";
}
