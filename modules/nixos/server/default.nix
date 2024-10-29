{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.srvos.nixosModules.server
  ];

  # Disable kernel module loading once the system is fully initialised.
  security.lockKernelModules = true;
}
