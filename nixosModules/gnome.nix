{ inputs, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

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
    adw-gtk3

    # Tool to fix Mesa 23.0+ trolls
    inputs.self.packages.${pkgs.system}.gpucache
  ];

  fonts = {
    packages = with pkgs; [
      cascadia-code # S-tier font for terminal
      inputs.google-sans-nix.packages.${pkgs.system}.default
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-extra
    ];
  };

  services.power-profiles-daemon.enable = false;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  programs.gamemode.enable = true;
}
