{
  config,
  perSystem,
  pkgs,
  ...
}:
{
  # other software
  environment.systemPackages = with pkgs; [
    # cli/tui tools
    _7zz
    abduco
    bat
    deadnix
    file
    flow-control
    ipgrep
    lurk
    ncdu
    nixfmt-rfc-style
    perSystem.self.safe-rm
    pv
    rage
    ripgrep
    shellcheck
    statix
    tre
    wget
    (writeScriptBin "7z" ''exec 7zz "$@"'')
    (writeScriptBin "jq" ''exec yq "$@"'')
    yq-go

    # system utilities
    bottom
    config.boot.kernelPackages.cpupower
    pciutils
    psmisc
    usbutils

    # network
    doggo
    goaccess
    inetutils
    magic-wormhole-rs
    rustscan
    speedtest-go
    wavemon
  ];
}
