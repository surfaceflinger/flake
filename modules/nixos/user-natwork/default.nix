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
        awscli2
        aws-rotate-key
        awsume
        buildah
        e1s
        eksctl
        gnumake
        google-cloud-sdk
        k9s
        kubernetes
        kubernetes-helm
        linkerd
        mariadb
        opentofu
        perSystem.cfn-changeset-viewer.default
        perSystem.tf."1.5.7"
        postgresql
        ssm-session-manager-plugin
        step-cli
      ]
      ++ lib.optionals config.services.xserver.enable [
        beekeeper-studio
        bitwarden
        freerdp
        perSystem.self.timedoctor-desktop
        slack
      ];
  };

  home-manager.users.natwork =
    { ... }:
    {
      imports = [
        inputs.self.homeModules.common
      ] ++ lib.optionals config.services.xserver.enable [ inputs.self.homeModules.desktop ];

      dconf.settings."org/gnome/shell/extensions/appindicator".legacy-tray-enabled = true;
    };

  nix.settings.trusted-users = [ "natwork" ];

  programs.zsh.shellAliases = {
    awsume = ". ${lib.getExe pkgs.awsume}";
    changeset = "${lib.getExe perSystem.cfn-changeset-viewer.default} --change-set-name";
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };

  # for now i'm using warp.sh as a replacement
  # because my vm doesn't pass device posture checks
  # https://github.com/rany2/warp.sh
  # services.cloudflare-warp.enable = true;
}
