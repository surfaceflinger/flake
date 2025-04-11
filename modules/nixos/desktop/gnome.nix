{
  perSystem,
  pkgs,
  ...
}:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.sessionVariables = {
    # nicer font rendering
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    # wayland in (most) electron apps
    NIXOS_OZONE_WL = "1";
  };

  # debloat
  environment.gnome.excludePackages = with pkgs; [
    baobab
    epiphany
    evince
    gnome-clocks
    gnome-console
    gnome-disk-utility
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-shell-extensions
    gnome-software
    gnome-system-monitor
    gnome-themes-extra
    gnome-tour
    gnome-user-docs
    orca
    totem
    yelp
  ];

  # other software
  environment.systemPackages = with pkgs; [
    # gnome
    ffmpegthumbnailer
    gnome-session
    gnome-tweaks

    # theming
    adw-gtk3
    morewaita-icon-theme

    # fetch gravatar and install as ~/.face
    perSystem.self.gnome-gravatar

    # the way weather works in gnome is terrible :(
    perSystem.self.gnome-weather-set
  ];

  fonts = {
    fontconfig.cache32Bit = true;
    packages = with pkgs; [
      cascadia-code
      inter
      merriweather
    ];
  };

  services.power-profiles-daemon.enable = false;
  programs.gamemode.enable = true;

  # qt gnome styling
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
