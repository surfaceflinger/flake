{ pkgs, ... }: {
  environment.memoryAllocator.provider = "graphene-hardened";
  security = {
    allowSimultaneousMultithreading = true;
    allowUserNamespaces = false;
    lockKernelModules = true;
  };

  boot.kernelParams = [ "nousb" ];

  boot.kernelPackages = pkgs.linuxPackages_hardened;
}
