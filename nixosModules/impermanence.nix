{ config, inputs, lib, ... }: {

  imports = [ inputs.impermanence.nixosModule ];

  options.ephemereal.enable = lib.mkEnableOption "Enables impermanence and sets up few things to make it work" // { default = false; };

  config = lib.mkIf config.ephemereal.enable {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      files = [ "/etc/machine-id" ];
    };
  };
}
