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
    ./openssh.nix
    ./system-packages.nix
    ./zsh.nix
  ];

  # zram
  zramSwap.enable = true;

  # Regional
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pl";

  # Time
  services.chrony = {
    enable = true;
    enableNTS = true;
    extraConfig = ''
      authselectmode require
      cmdport 0
      dscp 46
      leapsectz right/UTC
      makestep 1.0 3
      minsources 2
      rtcsync
    '';
  };
  networking.timeServers = [
    "time.cloudflare.com"
    "virginia.time.system76.com"
    "ptbtime1.ptb.de"
    "ntppool1.time.nl"
    "ntp.3eck.net"
    "ntp.trifence.ch"
    "ntp.zeitgitter.net"
  ];

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

  # sudo
  security.sudo = {
    wheelNeedsPassword = lib.mkOverride 10 true;
    execWheelOnly = true;
    extraConfig = ''
      Defaults lecture = never
      Defaults use_pty
    '';
  };

  # Configure home-manager
  home-manager.extraSpecialArgs.inputs = inputs; # forward the inputs
  home-manager.useGlobalPkgs = true; # don't create another instance of nixpkgs
  home-manager.useUserPackages = true; # install user packages directly to the user's profile
}
