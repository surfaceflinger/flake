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
      "podman"
    ];
    packages =
      with pkgs;
      [
        awscli2
        awsume
        buildah
        e1s
        eksctl
        gnumake
        google-cloud-sdk
        inputs.cfn-changeset-viewer.packages.${pkgs.system}.default
        inputs.tf.packages.${pkgs.system}."1.5.5"
        k9s
        kubernetes
        kubernetes-helm
        linkerd
        mysql
        opentofu
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
      imports = [
        inputs.self.homeModules.common
      ] ++ lib.optionals config.services.xserver.enable [ inputs.self.homeModules.desktop ];
    };

  nix.settings.trusted-users = [ "natwork" ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };
}
