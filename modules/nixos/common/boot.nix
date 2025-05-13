{ pkgs, ... }:
{
  # bootloader - hybrid limine installation
  boot.loader = {
    efi.canTouchEfiVariables = false;
    limine = {
      enable = true;
      biosSupport = pkgs.stdenv.hostPlatform.isx86;
      efiSupport = true;
      enableEditor = true;
    };
  };
}
