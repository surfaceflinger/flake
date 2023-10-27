{ ... }:
{
  flake.nixosModules = {
    # Presets
    common = ./common;
    desktop = ./desktop;
    laptop = ./laptop;
    server = ./server;
    vps = ./vps;

    # Mixins
    mitigations-off = ./mixins/mitigations-off.nix;
    virtualisation = ./mixins/virtualisation.nix;

    # Users
    nat = ./users/nat.nix;
    natwork = ./users/natwork.nix;
  };
}
