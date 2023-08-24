{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; lib.optionals config.services.xserver.enable [
    virt-manager
  ];

  virtualisation = {
    spiceUSBRedirection.enable = config.services.xserver.enable;
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = false;
        ovmf.enable = true;
      };
    };
  };
}
