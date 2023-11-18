{ config, inputs, pkgs, lib, ... }: {
  users.users.natwork = {
    uid = 1112;
    initialHashedPassword = "$6$L/BOe/brf592ULhC$aoO9LPG6YoTlqOoJYh588S1vq7ejtuTY.myBiBt638.zo4IzpmiadnYKlg4xGV.x6NgOBZaSyCzNzzHLUjQq9/";
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" ];
    packages = with pkgs; [
      # work
      awscli2
      awsume
      eksctl
      goaccess
      google-cloud-sdk
      k9s
      kubernetes
    ]
    ++ lib.optionals config.services.xserver.enable [
      bitwarden
      inputs.self.packages."${pkgs.system}".timedoctor-desktop
      slack
    ];
  };

  home-manager.users.natwork = { ... }: {
    imports = [ ./hmModules/common.nix ];
  };

  nix.settings.trusted-users = [ "natwork" ];
  nixpkgs.config.permittedInsecurePackages = [ "timedoctor-desktop-3.12.16" ];
}
