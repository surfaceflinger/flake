{ pkgs, ... }:
{
  projectRootFile = "flake.lock";
  programs.deadnix.enable = true;
  programs.nixfmt = {
    enable = true;
    package = pkgs.nixfmt-rfc-style;
  };
}
