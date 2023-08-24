{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Debloat
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-connections
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
      gedit
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-shell-extensions
      gnome-software
      gnome-system-monitor
      gnome-themes-extra
      gnome-weather
      simple-scan
      totem
      yelp
    ]);

  # Other software
  environment.systemPackages = with pkgs; [
    # GNOME
    gnomeExtensions.user-themes
    gnome.gnome-session
    blackbox-terminal

    # Theming
    adw-gtk3
  ];

  fonts = {
    packages = with pkgs; [
      cascadia-code # S-tier font for terminal
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-extra
    ];
  };

  services.power-profiles-daemon.enable = false;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
