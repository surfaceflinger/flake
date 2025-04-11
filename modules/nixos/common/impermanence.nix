{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModule ];

  config = lib.mkIf config.isEphemeral {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      enableWarnings = false;
      hideMounts = true;
    };
  };
}
