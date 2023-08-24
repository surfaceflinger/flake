{ inputs, ... }: {
  imports = [
    inputs.srvos.nixosModules.server
    ./common.nix
  ];
}
