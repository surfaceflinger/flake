_: {
  security.lockKernelModules = true;
  boot.kernelParams = [
    # i don't remember having any usb devices even on my physical servers :)
    "usbcore.nousb"
  ];
}
