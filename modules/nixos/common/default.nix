{
  inputs,
  perSystem,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.self.nixosModules.mixin-hardening
    ./agenix.nix
    ./boot.nix
    ./chrony.nix
    ./doas.nix
    ./impermanence.nix
    ./memory.nix
    ./nano.nix
    ./networking.nix
    ./nix.nix
    ./regional.nix
    ./system-packages.nix
    ./zfs.nix
    ./zsh.nix
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # firmware/hardware updates and security status
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

  # openssh everywhere
  services.openssh.enable = true;

  # configure home-manager
  home-manager.extraSpecialArgs.inputs = inputs; # forward the inputs
  home-manager.extraSpecialArgs.perSystem = perSystem; # forward blueprint's perSystem
  home-manager.useGlobalPkgs = true; # don't create another instance of nixpkgs
  home-manager.useUserPackages = true; # install user packages directly to the user's profile

  # temporary until someone bumps zfs unstable in nixpkgs
  # otherwise current unstable works fine
  nixpkgs.config.allowBroken = true;
}
