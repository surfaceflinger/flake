{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "gnome-gravatar";
  runtimeInputs = [ pkgs.curl ];
  text = builtins.readFile ./gravatar.sh;
}
