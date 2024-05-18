{ inputs, ... }:
{
  imports = [ inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate ];

  programs.ryzen-monitor-ng.enable = true;
}
