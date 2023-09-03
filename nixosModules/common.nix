{ inputs, lib, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
    ./agenix.nix
    ./boot.nix
    ./hardening.nix
    ./impermanence.nix
    ./nano.nix
    ./networking.nix
    ./nix.nix
    ./system-packages.nix
    ./zfs.nix
    ./zsh.nix
  ];

  # zram
  zramSwap.enable = true;

  # Regional
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pl";
  time.timeZone = "Europe/Warsaw";

  # Disable coredumps
  security.pam.loginLimits = [
    {
      domain = "*";
      item = "core";
      type = "hard";
      value = "0";
    }
  ];
  systemd.coredump.enable = false;

  # SSH everywhere
  services.openssh.enable = true;

  # firmware updates
  services.fwupd.enable = true;

  # Override srvos changes
  programs.vim.defaultEditor = false;
  boot.initrd.systemd.enable = false;
  services.cloud-init.enable = false;

  # sudo
  security.sudo = {
    wheelNeedsPassword = lib.mkOverride 10 true;
    execWheelOnly = true;
    extraConfig = ''
      Defaults lecture = never
    '';
  };

  # Configure home-manager
  home-manager.extraSpecialArgs.inputs = inputs; # forward the inputs
  home-manager.useGlobalPkgs = true; # don't create another instance of nixpkgs
  home-manager.useUserPackages = true; # install user packages directly to the user's profile
}
