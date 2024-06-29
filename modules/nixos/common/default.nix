{ inputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.self.nixosModules.mixin-hardening
    ./agenix.nix
    ./boot.nix
    ./chrony.nix
    ./doas.nix
    ./impermanence.nix
    ./nano.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./regional.nix
    ./system-packages.nix
    ./zfs.nix
    ./zram.nix
    ./zsh.nix
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # firmware updates
  services.fwupd.enable = true;

  # override srvos changes
  programs.vim.defaultEditor = false;

  # configure cloud-init (enabled where needed)
  systemd.tmpfiles.rules = [ "R /var/lib/cloud" ];
  services.cloud-init.settings = {
    random_seed.file = "/dev/null";
  };

  # reliability, availability and serviceability
  hardware.rasdaemon.enable = true;

  # configure home-manager
  home-manager.extraSpecialArgs.inputs = inputs; # forward the inputs
  home-manager.useGlobalPkgs = true; # don't create another instance of nixpkgs
  home-manager.useUserPackages = true; # install user packages directly to the user's profile
}
