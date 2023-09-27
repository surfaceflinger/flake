{ lib, pkgs, osConfig, ... }:
{
  config = lib.mkIf (osConfig.services.xserver.enable) {
    services.easyeffects.enable = true;

    xdg.configFile = {
      "easyeffects/irs/google-pixel-buds-pro-autoeq.irs".source = pkgs.fetchurl {
        url = "https://github.com/jaakkopasanen/AutoEq/raw/3.0.0/results/Rtings/in-ear/Google%20Pixel%20Buds%20Pro/Google%20Pixel%20Buds%20Pro%20minimum%20phase%2048000Hz.wav";
        hash = "sha256-Oh4+QegYb2W1uWUTiBPOT95VOSyhFT/QSRahNxGDONs=";
      };

      "easyeffects/irs/sennheiser-hd-599-autoeq.irs".source = pkgs.fetchurl {
        url = "https://github.com/jaakkopasanen/AutoEq/raw/3.0.0/results/oratory1990/over-ear/Sennheiser%20HD%20599/Sennheiser%20HD%20599%20minimum%20phase%2048000Hz.wav";
        hash = "sha256-lbkv+AhWhwtHgzuP+MamG0qdKL5Zp0wycihGUDo3fiw=";
      };
    };
  };
}
