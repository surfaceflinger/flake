{ inputs, lib, ... }:
{
  imports = [ inputs.self.nixosModules.server ];
  hardware.enableAllFirmware = lib.mkForce false;
}
