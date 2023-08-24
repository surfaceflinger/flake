{ config, inputs, pkgs, lib, ... }: {
  users.users.natwork = {
    uid = 1112;
    initialHashedPassword = "$6$L/BOe/brf592ULhC$aoO9LPG6YoTlqOoJYh588S1vq7ejtuTY.myBiBt638.zo4IzpmiadnYKlg4xGV.x6NgOBZaSyCzNzzHLUjQq9/";
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      # work
      awscli2
      awsume
    ]
    ++ lib.optionals config.services.xserver.enable [
      slack
      inputs.self.packages.${pkgs.system}.timedoctor-desktop
    ];
  };

  systemd.tmpfiles.rules = [ "d /home/natwork 0700 natwork users - -" ];

  home-manager.users.natwork = { ... }: {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
    ] ++ lib.optionals config.services.xserver.enable [
      ./dconf.nix
      ./mpv.nix
    ];

    home.stateVersion = "22.11";
  };

  nix.settings.trusted-users = [ "natwork" ];
  nixpkgs.config.permittedInsecurePackages = [ "timedoctor-desktop-3.12.16" ];
}
