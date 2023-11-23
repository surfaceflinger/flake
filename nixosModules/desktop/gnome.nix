{ inputs, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Debloat
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-console
      gnome-photos
      gnome-text-editor
      gnome-tour
      gnome-user-docs
      orca
    ])
    ++ (with pkgs.gnome; [
      baobab
      cheese
      epiphany
      evince
      geary
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-disk-utility
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-shell-extensions
      gnome-software
      gnome-system-monitor
      gnome-themes-extra
      gnome-weather
      seahorse
      simple-scan
      totem
      yelp
    ]);

  # Other software
  environment.systemPackages = with pkgs; [
    # GNOME
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnome.gnome-session
    blackbox-terminal

    # Theming
    graphite-gtk-theme
    papirus-icon-theme

    # Tool to fix Mesa 23.0+ trolls
    inputs.self.packages.${pkgs.system}.gpucache
  ];

  nixpkgs.overlays = [
    (_final: prev: {
      graphite-gtk-theme = (prev.graphite-gtk-theme.override { themeVariants = [ "pink" ]; colorVariants = [ "dark" ]; tweaks = [ "darker" "normal" "rimless" ]; });
    })
  ];

  fonts = {
    fontconfig.defaultFonts = {
      monospace = [ "Cascadia Code PL" ];
      sansSerif = [ "IBM Plex Sans" ];
      serif = [ "IBM Plex Serif" ];
    };
    packages = with pkgs; [
      cascadia-code
      ibm-plex
    ];
  };

  services.power-profiles-daemon.enable = false;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  programs.gamemode.enable = true;
}
