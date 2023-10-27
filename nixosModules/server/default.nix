{ inputs, ... }: {
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.server
    ./hardening.nix
  ];
}
