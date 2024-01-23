{ pkgs, ... }:
{
  security.lockKernelModules = true;
  boot.kernelParams = [
    # I don't remember having any USB devices even on my physical servers :)
    "usbcore.nousb"
  ];
  boot.kernelPackages = pkgs.linuxPackages_6_6_hardened;
}
