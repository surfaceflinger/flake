{
  lib,
  ...
}:
{
  options = {
    isDesktop = lib.mkEnableOption "Mark the host as desktop";
    isEphemeral = lib.mkEnableOption "Enables impermanence and sets up few things to make it work";
  };
}
