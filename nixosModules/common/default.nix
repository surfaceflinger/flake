{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./agenix.nix
    ./boot.nix
    ./chrony.nix
    ./doas.nix
    ./hardening.nix
    ./impermanence.nix
    ./nano.nix
    ./networking.nix
    ./nix.nix
    ./openssh.nix
    ./system-packages.nix
    ./zfs.nix
    ./zram.nix
    ./zsh.nix
  ];

  # Regional
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pl";

  # firmware updates
  services.fwupd.enable = true;

  # Override srvos changes
  programs.vim.defaultEditor = false;

  # Configure cloud-init (enabled where needed)
  systemd.tmpfiles.rules = [ "R /var/lib/cloud" ];
  services.cloud-init.settings = {
    random_seed.file = "/dev/null";
  };

  # Virtual memory
  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 3;
    "vm.dirty_ratio" = 10;
    "vm.vfs_cache_pressure" = 50;
  };

  # Configure home-manager
  home-manager.extraSpecialArgs.inputs = inputs; # forward the inputs
  home-manager.useGlobalPkgs = true; # don't create another instance of nixpkgs
  home-manager.useUserPackages = true; # install user packages directly to the user's profile
}
