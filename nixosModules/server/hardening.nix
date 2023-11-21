{ pkgs, ... }: {
  security.lockKernelModules = true;
  boot.kernelParams = [ "usbcore.nousb" ];
  boot.kernelPackages = pkgs.linuxPackages_hardened;
}
