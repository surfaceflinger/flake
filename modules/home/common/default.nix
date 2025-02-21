{
  inputs,
  osConfig,
  perSystem,
  ...
}:
{
  imports = [
    ./git.nix
    inputs.dont-track-me.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = osConfig.system.stateVersion;

  dont-track-me = {
    enable = true;
    enableAll = true;
  };

  home.packages = [
    perSystem.self.safe-rm
  ];
}
