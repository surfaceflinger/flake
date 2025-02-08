{ lib, ... }:
{
  services.printing = {
    enable = true;
    webInterface = false;
    stateless = true;
  };

  hardware.printers = {
    ensureDefaultPrinter = "Library";
    ensurePrinters = lib.singleton {
      deviceUri = "ipp://skogsduva/ipp/print";
      model = "everywhere";
      name = "Library";
      ppdOptions = {
        Duplex = "DuplexNoTumble";
        PageSize = "A4";
      };
    };
  };
}
