{ ... }:
{
  flake.nixosModules = {
    common = ./common.nix;
    desktop = ./desktop.nix;
    laptop = ./laptop.nix;
    server = ./server.nix;
    nat = ./users/nat.nix;
    natwork = ./users/natwork.nix;
  };
}
