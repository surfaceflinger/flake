{
  config,
  inputs,
  lib,
  perSystem,
  pkgs,
  ...
}:
{
  users.users.nat = {
    uid = 1111;
    initialHashedPassword = "$6$lR2ORA5b3eQUIqWN$W0RFJ7/5jWfajKZl2CfSwp5/BmUIzuS5OnRvksaUWmN575fubdRMybKDAFKKDnh67k6z39qjNlMLiI/drslNv1";
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "audio"
      "corectrl"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
      builtins.readFile ../../../keys/nat.ssh.keys
    );
    packages =
      with pkgs;
      [
        perSystem.agenix.default
        perSystem.self.swift-backup
      ]
      ++ lib.optionals config.isDesktop [
        # random desktop software
        brave
        burpsuite
        diebahn
        fractal
        fragments
        gnome-podcasts
        newsflash
        signal-desktop
        (telegram-desktop.override { withWebkit = false; })
        tuba
        vesktop

        # crypto/fin
        feather
        ledger-live-desktop
        rates
        trezor-agent
        trezorctl
        trezor-suite
        wealthfolio

        # ops
        opentofu
        scaleway-cli

        # misc
        binsider
      ];
  };

  home-manager.users.nat =
    { ... }:
    {
      imports =
        [
          inputs.self.homeModules.common
        ]
        ++ lib.optionals config.isDesktop [
          inputs.self.homeModules.desktop
          ./halloy.nix
        ];

      programs.git = {
        userEmail = "nat@nekopon.pl";
        userName = "nat";
      };

      systemd.user.tmpfiles.rules = [ "D %h/Downloads 0700 - - -" ];
    };

  # crypto hw wallets!
  hardware.ledger.enable = config.isDesktop;
  services.trezord.enable = config.isDesktop;

  nix.settings.trusted-users = [ "nat" ];
}
