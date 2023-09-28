{ config, inputs, lib, ... }:
#let
#  isEphemereal = (config.fileSystems."/".fsType or "") == "tmpfs";
#in
{
  imports = [ inputs.impermanence.nixosModule ];

  options.ephemereal = lib.mkEnableOption "Enables impermanence and sets up few things to make it work" // { default = false; };

  config = lib.mkIf config.ephemereal {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      files = [ "/etc/machine-id" ];
    };
  };
}
