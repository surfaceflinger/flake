{ config, inputs, lib, ... }: {

  imports = [ inputs.impermanence.nixosModule ];
  options.ephemereal.enable = lib.mkEnableOption "Enables impermanence and sets up few things to make it work" // { default = true; };

  config = lib.mkIf config.ephemereal.enable {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      files = [
        "/etc/machine-id"
      ] ++ lib.optionals config.services.openssh.enable [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];
    };
  };
}
