{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./agenix.nix
    ./boot.nix
    ./chrony.nix
    ./hardening.nix
    ./impermanence.nix
    ./nano.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./system-packages.nix
    ./zfs.nix
    ./zsh.nix
  ];

  # zram
  zramSwap.enable = true;

  # Regional
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pl";

  # firmware updates
  services.fwupd.enable = true;

  # Override srvos changes
  programs.vim.defaultEditor = false;

  # Configure cloud-init (where needed)
  systemd.tmpfiles.rules = [ "R /var/lib/cloud" ];
  services.cloud-init.settings = {
    ssh_deletekeys = false;
    random_seed.file = "/dev/null";
  };

  # doas
  security = {
    sudo.enable = lib.mkForce false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "root" ];
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  # Configure home-manager
  home-manager.extraSpecialArgs.inputs = inputs; # forward the inputs
  home-manager.useGlobalPkgs = true; # don't create another instance of nixpkgs
  home-manager.useUserPackages = true; # install user packages directly to the user's profile
}
