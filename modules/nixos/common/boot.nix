_: {
  # bootloader - hybrid limine installation
  boot.loader = {
    efi.canTouchEfiVariables = false;
    limine = {
      enable = true;
      efiSupport = true;
      enableEditor = true;
    };
  };
}
