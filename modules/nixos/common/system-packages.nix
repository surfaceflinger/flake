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
    dyff
    eza
    file
    gojq
    ipgrep
    ncdu
    nixfmt-rfc-style
    ouch
    perSystem.self.safe-rm
    pv
    rage
    ripgrep
    shellcheck
    statix
    wget
    (writeScriptBin "7z" ''exec 7zz "$@"'')
    (writeScriptBin "goto-nix" ''cd $(nix build -L --print-out-paths --no-link "$@".out) && $SHELL'')
    (writeScriptBin "jq" ''exec gojq "$@"'')
    yq-go

    # system utilities
    bottom
    config.boot.kernelPackages.cpupower
    fastfetch
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

  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
  };
}
