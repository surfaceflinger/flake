{ inputs, lib, osConfig, ... }: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ] ++ lib.optionals osConfig.services.xserver.enable [
    ./dconf.nix
    ./easyeffects.nix
    ./mpv.nix
  ];

  home.stateVersion = "22.11";
}
