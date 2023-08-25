{ config, inputs, lib, ... }: {

  imports = [ inputs.impermanence.nixosModule ];

  options.ephemereal.enable = lib.mkEnableOption "Enables impermanence and sets up few things to make it work" // { default = true; };

  config.environment.persistence."/persist" = {
    hideMounts = true;
    files = [
      "/etc/machine-id"
    ];
  };

  config.fileSystems."/persist".neededForBoot = true;
  config.fileSystems."/etc/ssh".neededForBoot = true;
}
