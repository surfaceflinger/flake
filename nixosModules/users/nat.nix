{
  config,
  inputs,
  lib,
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
    openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ./nat.keys);
    packages =
      with pkgs;
      [
        inputs.agenix.packages.${pkgs.system}.default
        inputs.self.packages.${pkgs.system}.swift-backup
      ]
      ++ lib.optionals config.services.xserver.enable [
        # Random desktop software
        bavarder
        burpsuite
        diebahn
        fractal
        gnome-podcasts
        halloy
        newsflash
        signal-desktop
        telegram-desktop
        transmission_4-gtk
        tuba
        vesktop

        # crypto/fin
        feather
        ledger-live-desktop
        rates
      ];
  };

  home-manager.users.nat =
    { ... }:
    {
      imports = [
        inputs.self.homeManagerModules.common
      ] ++ lib.optionals config.services.xserver.enable [ inputs.self.homeManagerModules.desktop ];

      programs.git = {
        userEmail = "nat@nekopon.pl";
        userName = "nat";
      };
    };
}
