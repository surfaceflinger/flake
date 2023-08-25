{ ... }:
{
  flake.nixosModules = {
    common = ./common.nix;
    desktop = ./desktop.nix;
    laptop = ./laptop.nix;
    nat = ./users/nat.nix;
    natwork = ./users/natwork.nix;
    server = ./server.nix;
    virtualisation = ./virtualisation.nix;
  };
}
