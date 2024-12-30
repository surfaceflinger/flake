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
    ghostty
    gnome-session
    gnome-tweaks
    ptyxis

    # theming
    adw-gtk3
    morewaita-icon-theme

    # fetch gravatar and install as ~/.face
    perSystem.self.gnome-gravatar

    # the way weather works in gnome is terrible :(
    perSystem.self.gnome-weather-set
  ];

  # make ghostty run without io_uring
  nixpkgs.overlays = [
    (_self: super: {
      ghostty = super.ghostty.overrideAttrs (_oldAttrs: {
        patchPhase = ''
          find . -name "*.zig" -exec sh -c 'echo "Patching: $1"; sed -i "s/^const xev = @import(\"xev\");$/const xev = @import(\"xev\").Epoll;/" "$1"' _ {} \;
        '';
      });
    })
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
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  programs.gamemode.enable = true;

  # qt gnome styling
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
