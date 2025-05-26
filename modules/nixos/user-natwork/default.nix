{
  config,
  inputs,
  lib,
  perSystem,
  pkgs,
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
        argocd
        awscli2
        awsume
        buildah
        cfn-nag
        eksctl
        gnumake
        (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
        k9s
        kubectl
        kubernetes-helm
        mariadb
        opentofu
        perSystem.cfn-changeset-viewer.default
        perSystem.tf."1.5.7"
        postgresql
        siege
        ssm-session-manager-plugin
        teleport
      ]
      ++ lib.optionals config.isDesktop [
        beekeeper-studio
        bitwarden
        brave
        freerdp
        obs-studio
        perSystem.self.timedoctor-desktop
        slack
      ];
  };

  home-manager.users.natwork =
    { ... }:
    {
      imports = [
        inputs.self.homeModules.common
      ] ++ lib.optionals config.isDesktop [ inputs.self.homeModules.desktop ];

      dconf.settings."org/gnome/shell/extensions/appindicator".legacy-tray-enabled = true;

      services.podman.enable = true;
    };

  programs.zsh.shellAliases = {
    awsume = ". ${lib.getExe pkgs.awsume}";
    changeset = "${lib.getExe perSystem.cfn-changeset-viewer.default} --change-set-name";
  };
}
