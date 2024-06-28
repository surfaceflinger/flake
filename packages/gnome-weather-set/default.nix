{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "gnome-weather-set";
  runtimeInputs = [
    pkgs.curl
    pkgs.dconf
    pkgs.jq
    pkgs.bc
  ];
  text = builtins.readFile ./weather.sh;
}
