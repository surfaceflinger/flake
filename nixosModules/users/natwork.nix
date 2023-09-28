{ config, pkgs, lib, ... }: {
  users.users.natwork = {
    uid = 1112;
    initialHashedPassword = "$6$L/BOe/brf592ULhC$aoO9LPG6YoTlqOoJYh588S1vq7ejtuTY.myBiBt638.zo4IzpmiadnYKlg4xGV.x6NgOBZaSyCzNzzHLUjQq9/";
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" ];
    packages = with pkgs; [
      # work
      awscli2
      awsume
    ]
    ++ lib.optionals config.services.xserver.enable [
      slack
      timedoctor-desktop
    ];
  };

  home-manager.users.natwork = { ... }: {
    imports = [ ./hmModules/common.nix ];
  };

  nix.settings.trusted-users = [ "natwork" ];
  nixpkgs.config.permittedInsecurePackages = [ "timedoctor-desktop-3.12.16" ];
}
