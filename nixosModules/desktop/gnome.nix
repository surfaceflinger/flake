{ inputs, pkgs, ... }:
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

  # Debloat
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-console
      gnome-photos
      gnome-tour
      gnome-user-docs
      orca
    ])
    ++ (with pkgs.gnome; [
      baobab
      epiphany
      evince
      gnome-clocks
      gnome-disk-utility
      gnome-logs
      gnome-maps
      gnome-music
      gnome-shell-extensions
      gnome-software
      gnome-system-monitor
      gnome-themes-extra
      totem
      yelp
    ]);

  # Other software
  environment.systemPackages = with pkgs; [
    # GNOME
    ffmpegthumbnailer
    gnomeExtensions.appindicator
    gnomeExtensions.auto-move-windows
    gnomeExtensions.caffeine
    gnomeExtensions.tailscale-qs
    gnomeExtensions.user-avatar-in-quick-settings
    gnomeExtensions.user-themes
    gnomeExtensions.window-is-ready-remover
    gnome.gnome-session
    gnome.gnome-tweaks
    ptyxis

    # Theming
    adw-gtk3
    morewaita-icon-theme

    # Tool to fix Mesa 23.0+ trolls
    inputs.self.packages.${pkgs.system}.gpucache

    # Fetch gravatar and install as ~/.face
    inputs.self.packages.${pkgs.system}.gnome-gravatar

    # The way Weather works in GNOME is terrible :(
    inputs.self.packages.${pkgs.system}.gnome-weather-set

    # show dconf nicely
    (pkgs.writeScriptBin "dconf-dump" ''exec dconf dump / | bat -l toml'')
  ];

  fonts = {
    fontconfig.defaultFonts = {
      monospace = [ "Cascadia Mono PL" ];
      sansSerif = [ "Inter Variable" ];
      serif = [ "Inter Variable" ];
    };
    packages = with pkgs; [
      cascadia-code
      inter
    ];
  };

  services.power-profiles-daemon.enable = false;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  programs.gamemode.enable = true;

  # QT GNOME styling
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  #  Dynamic triple/double buffering (v4)
  nixpkgs.overlays = [
    (_final: prev: {
      gnome = prev.gnome.overrideScope (
        _gfinal: _gprev: {
          mutter = _gprev.mutter.overrideAttrs (oldAttrs: {
            patches = [ ./mr1441.patch ] ++ (oldAttrs.patches or [ ]);
          });
        }
      );
    })
  ];
}
