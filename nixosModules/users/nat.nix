{ config, inputs, pkgs, lib, ... }: {
  users.users.nat = {
    uid = 1111;
    initialHashedPassword = "$6$lR2ORA5b3eQUIqWN$W0RFJ7/5jWfajKZl2CfSwp5/BmUIzuS5OnRvksaUWmN575fubdRMybKDAFKKDnh67k6z39qjNlMLiI/drslNv1";
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "adbusers" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3qUEH9FtVeyUTTYTIXfKXnKtmw6mRX9g/Xo3/iKfwp termux@panther"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGeYYGkVH8pPo1f769OHYn6Vga6wnhftJA6w2IJADzgs nat@blahaj"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLC2drRTlZnQILQ/SdoZVC+Zw1SK2+L9czCHuMNBzd6 nat@djungelskog"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCkLPQTcoK0dAOvRT2tyZObxF6BfacmAkeHQxhHV3ZU nat@knorrig"
    ];
    packages = with pkgs; [
      inputs.self.packages.${pkgs.system}.swift-backup
    ] ++ lib.optionals config.services.xserver.enable [
      # Desktop software
      (discord-canary.override { withOpenASAR = true; })
      inputs.self.packages.${pkgs.system}.krisp-patch
      qbittorrent
      tdesktop

      # Crypto
      electrum
      electrum-ltc
      ledger-live-desktop
      monero-gui

      # Gaming
      bottles
      gamescope
      jazz2
      lunar-client
      prismlauncher
    ];
  };

  systemd.tmpfiles.rules = [ "d /home/nat 0700 nat users - -" ];

  programs.git = {
    enable = true;
  };

  home-manager.users.nat = { ... }: {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
    ] ++ lib.optionals config.services.xserver.enable [
      ./dconf.nix
      ./mpv.nix
    ];

    programs.git = {
      enable = true;
      userEmail = "nat@nekopon.pl";
      userName = "nat";
      extraConfig = {
        tag.gpgsign = true;
        core.editor = with pkgs; (lib.getExe nano);
        commit.gpgsign = true;
        gpg = {
          format = "ssh";
          ssh.defaultKeyCommand = "ssh-add -L";
        };
        pull.rebase = true;
      };
    };

    home.stateVersion = "22.11";
  };
}
