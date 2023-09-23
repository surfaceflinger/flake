{ inputs, lib, pkgs, ... }: {
  imports = [
    inputs.srvos.nixosModules.server
    ./common.nix
  ];

  environment.memoryAllocator.provider = lib.mkForce "jemalloc";
  boot.kernelPackages = pkgs.linuxPackages_hardened;
}
