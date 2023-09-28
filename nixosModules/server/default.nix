{ inputs, lib, pkgs, ... }: {
  imports = [
    inputs.self.nixosModules.common
    inputs.self.nixosModules.hardening
    inputs.srvos.nixosModules.server
  ];

  environment.memoryAllocator.provider = lib.mkForce "jemalloc";
  boot.kernelPackages = pkgs.linuxPackages_hardened;
}
