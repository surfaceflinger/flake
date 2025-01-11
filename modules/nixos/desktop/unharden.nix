{ lib, ... }:
{
  nix-mineral.overrides = {
    desktop = {
      allow-multilib = true;
      allow-unprivileged-userns = true;
      hideproc-ptraceable = true;
      home-exec = true;
      tmp-exec = true;
      disable-usbguard = true;
      yama-relaxed = true;
    };
    performance.no-pti = true;
    security = {
      disable-bluetooth-kmodules = lib.mkForce false;
    };
  };
}
