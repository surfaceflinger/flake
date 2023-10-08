{ config, inputs, pkgs, lib, ... }: {
  users.users.nat = {
    uid = 1111;
    initialHashedPassword = "$6$lR2ORA5b3eQUIqWN$W0RFJ7/5jWfajKZl2CfSwp5/BmUIzuS5OnRvksaUWmN575fubdRMybKDAFKKDnh67k6z39qjNlMLiI/drslNv1";
    isNormalUser = true;
    extraGroups = [ "audio" "wheel" "libvirtd" "networkmanager" "adbusers" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn8HsKgSJJzxAvKdkEJRYLLOVv9NCWohhd/EKkPjsjq termius@panther"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGeYYGkVH8pPo1f769OHYn6Vga6wnhftJA6w2IJADzgs nat@blahaj"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKLC2drRTlZnQILQ/SdoZVC+Zw1SK2+L9czCHuMNBzd6 nat@djungelskog"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCkLPQTcoK0dAOvRT2tyZObxF6BfacmAkeHQxhHV3ZU nat@knorrig"
    ];
    packages = with pkgs; [
      inputs.agenix.packages.${pkgs.system}.default
      inputs.self.packages.${pkgs.system}.swift-backup
    ] ++ lib.optionals config.services.xserver.enable [
      # Desktop software
      (discord.override { withOpenASAR = true; })
      #inputs.self.packages.${pkgs.system}.krisp-patch
      qbittorrent
      tdesktop

      # Crypto
      ledger-live-desktop
      monero-gui

      # Gaming
      jazz2
      lunar-client
      (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override { glfw = glfw-wayland-minecraft; })
    ];
  };

  home-manager.users.nat = { ... }: {
    imports = [ ./hmModules/common.nix ];

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

  };
}
