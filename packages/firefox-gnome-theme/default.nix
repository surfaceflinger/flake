{ pkgs, ... }:
pkgs.fetchFromGitHub {
  owner = "rafaelmardojai";
  repo = "firefox-gnome-theme";
  rev = "v128";
  hash = "sha256-zB+Zd0V0ayKP/zg9n1MQ8J/Znwa49adylRftxuc694k=";
}
