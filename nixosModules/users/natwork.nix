{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  users.users.natwork = {
    uid = 1112;
    initialHashedPassword = "$6$L/BOe/brf592ULhC$aoO9LPG6YoTlqOoJYh588S1vq7ejtuTY.myBiBt638.zo4IzpmiadnYKlg4xGV.x6NgOBZaSyCzNzzHLUjQq9/";
    isNormalUser = true;
    extraGroups = [
      "audio"
      "libvirtd"
      "networkmanager"
    ];
    packages =
      with pkgs;
      [
        awscli2
        awsume
        eksctl
        gnumake
        google-cloud-sdk
        k9s
        kubernetes
        kubernetes-helm
        linkerd
        ssm-session-manager-plugin
        step-cli
      ]
      ++ lib.optionals config.services.xserver.enable [
        beekeeper-studio
        bitwarden
        freerdp
        inputs.self.packages.${pkgs.system}.timedoctor-desktop
        slack
      ];
  };

  home-manager.users.natwork =
    { ... }:
    {
      imports = [ inputs.self.homeManagerModules.common ];
    };

  nix.settings.trusted-users = [ "natwork" ];
  nixpkgs.config.permittedInsecurePackages = [ "timedoctor-desktop-3.12.16" ];
}
