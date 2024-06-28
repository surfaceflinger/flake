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
    # browser
    BROWSER = "schizofox";
  };

  # debloat
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

  # other software
  environment.systemPackages = with pkgs; [
    # gnome
    ffmpegthumbnailer
    gnomeExtensions.appindicator
    gnomeExtensions.auto-move-windows
    gnomeExtensions.caffeine
    gnomeExtensions.pip-on-top
    gnomeExtensions.tailscale-qs
    gnomeExtensions.user-avatar-in-quick-settings
    gnomeExtensions.window-is-ready-remover
    gnome.gnome-session
    gnome.gnome-tweaks
    ptyxis

    # theming
    adw-gtk3
    morewaita-icon-theme

    # tool to fix mesa 23.0+ trolls
    inputs.self.packages.${pkgs.system}.gpucache

    # fetch gravatar and install as ~/.face
    inputs.self.packages.${pkgs.system}.gnome-gravatar

    # the way weather works in gnome is terrible :(
    inputs.self.packages.${pkgs.system}.gnome-weather-set

    # show dconf nicely
    (pkgs.writeScriptBin "dconf-dump" ''exec dconf dump / | bat -l toml'')
  ];

  fonts = {
    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        monospace = [
          "Cascadia Mono PL"
          "Noto Sans Mono"
          "Noto Sans Mono CJK HK"
          "Noto Sans Mono CJK JP"
          "Noto Sans Mono CJK KR"
          "Noto Sans Mono CJK SC"
          "Noto Sans Mono CJK TC"
        ];
        sansSerif = [
          "Inter Variable"
          "Inter"
          "Noto Sans"
          "Noto Sans CJK HK"
          "Noto Sans CJK JP"
          "Noto Sans CJK KR"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
        ];
        serif = [
          "Merriweather"
          "Noto Serif"
          "Noto Serif CJK HK"
          "Noto Serif CJK JP"
          "Noto Serif CJK KR"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
        ];
      };
    };
    packages = with pkgs; [
      cascadia-code
      inter
      merriweather
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };

  services.power-profiles-daemon.enable = false;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  programs.gamemode.enable = true;

  # qt gnome styling
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  #  dynamic triple/double buffering (v4)
  nixpkgs.overlays = [
    (_self: super: {
      gnome = super.gnome.overrideScope (
        _self: gsuper: { mutter = gsuper.mutter.overrideAttrs { src = inputs.mutter; }; }
      );
    })
  ];
}
