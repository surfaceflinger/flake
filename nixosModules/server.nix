{ inputs, lib, ... }: {
  imports = [
    inputs.srvos.nixosModules.server
    ./common.nix
  ];

  environment.memoryAllocator.provider = lib.mkForce "jemalloc";
}
