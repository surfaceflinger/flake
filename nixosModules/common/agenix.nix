{ config, inputs, ... }: {
  imports = [ inputs.agenix.nixosModules.default ];
  fileSystems."/etc/ssh".neededForBoot = config.ephemereal;
}
