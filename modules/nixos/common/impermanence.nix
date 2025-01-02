{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModule ];

  options.ephemeral = lib.mkEnableOption "Enables impermanence and sets up few things to make it work";

  config = lib.mkIf config.ephemeral {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      enableWarnings = false;
      hideMounts = true;
    };
  };
}
