{ inputs, ... }: {
  imports = [
    inputs.self.nixosModules.mitigations-off
    inputs.self.nixosModules.server
  ];
}
