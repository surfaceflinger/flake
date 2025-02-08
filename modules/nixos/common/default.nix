{
  config,
  inputs,
  perSystem,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./agenix.nix
    ./boot.nix
    ./chrony.nix
    ./doas.nix
    ./hardening.nix
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
  boot.kernelPackages =
    if config.services.xserver.enable then pkgs.linuxPackages_xanmod else pkgs.linuxPackages_hardened;

  # sched-ext
  services.scx = {
    enable = true;
    scheduler = if config.services.xserver.enable then "scx_bpfland" else "scx_rusty";
  };

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
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true; # don't create another instance of nixpkgs
    useUserPackages = true; # install user packages directly to the user's profile
    extraSpecialArgs = {
      inherit inputs; # forward the inputs
      inherit perSystem; # forward blueprint's perSystem
    };
  };
}
