{ config, inputs, lib, pkgs, ... }: {
  users.users.nat = {
    uid = 1111;
    initialHashedPassword = "$6$lR2ORA5b3eQUIqWN$W0RFJ7/5jWfajKZl2CfSwp5/BmUIzuS5OnRvksaUWmN575fubdRMybKDAFKKDnh67k6z39qjNlMLiI/drslNv1";
    isNormalUser = true;
    extraGroups = [ "audio" "wheel" "libvirtd" "networkmanager" "adbusers" ];
    openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ./nat.keys);
    packages = with pkgs; [
      inputs.agenix.packages.${pkgs.system}.default
      inputs.self.packages.${pkgs.system}.swift-backup
    ] ++ lib.optionals config.services.xserver.enable [
      # Desktop software
      burpsuite
      (discord.override { withOpenASAR = true; })
      telegram-desktop
      transmission_4-gtk

      # Crypto
      feather
      ledger-live-desktop

      # Gaming
      jazz2
      lunar-client
      (prismlauncher.override { glfw = glfw-wayland-minecraft; })
    ];
  };

  home-manager.users.nat = { ... }: {
    imports = [ inputs.self.homeManagerModules.common ];

    programs.git = {
      userEmail = "nat@nekopon.pl";
      userName = "nat";
    };
  };
}
