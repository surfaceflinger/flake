{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
  ];

  boot.kernelModules = [ "kvm-amd" ];
  services.hardware.openrgb.motherboard = "amd";
}
