{
  config,
  inputs,
  lib,
  ...
}:
#let
#  isephemereal = (config.filesystems."/".fstype or "") == "tmpfs";
#in
{
  imports = [ inputs.impermanence.nixosModule ];

  options.ephemereal =
    lib.mkEnableOption "Enables impermanence and sets up few things to make it work"
    // {
      default = false;
    };

  config = lib.mkIf config.ephemereal {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
    };
  };
}
