{ lib, osConfig, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    # gnome
    "org/gnome/desktop/app-folders" = {
      folder-children = [ "" ];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = false;
      experimental-features = [ "variable-refresh-rate" ];
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/shell" = {
      disable-extension-version-validation = true;
      app-picker-layout = [ "" ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.Ptyxis.desktop"
        "Schizofox.desktop"
        "org.telegram.desktop.desktop"
        "vesktop.desktop"
        "slack.desktop"
        "org.gnome.Fractal.desktop"
        "org.squidowl.halloy.desktop"
        "dev.geopjr.Tuba.desktop"
        "timedoctor-desktop.desktop"
        "org.gnome.Geary.desktop"
        "io.bassi.Amberol.desktop"
        "code.desktop"
        "io.gitlab.news_flash.NewsFlash.desktop"
        "org.prismlauncher.PrismLauncher.desktop"
        "lunarclient.desktop"
        "steam.desktop"
        "com.saivert.pwvucontrol.desktop"
        "com.github.wwmm.easyeffects.desktop"
        "virt-manager.desktop"
        "de.haeckerfelix.Fragments.desktop"
        "org.qbittorrent.qBittorrent.desktop"
        "bitwarden.desktop"
      ];
      welcome-dialog-last-shown-version = "999";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    # interface/theming
    "org/gnome/desktop/interface" = {
      accent-color = "pink";
      clock-show-weekday = true;
      document-font-name = "Merriweather 11";
      font-hinting = "none";
      font-name = "Inter Variable 11";
      gtk-enable-primary-paste = false;
      gtk-theme = "adw-gtk3";
      monospace-font-name = "Cascadia Mono PL 10";
      show-battery-percentage = true;
    };

    "org/gnome/shell/extensions/user-theme-x" = {
      x-color = "prefer-light";
      x-color-night = "prefer-dark";
      x-cursor = "miku-cursor";
      x-cursor-night = "miku-cursor";
      x-gtk = "adw-gtk3";
      x-gtk-night = "adw-gtk3-dark";
      x-icons = "MoreWaita";
      x-icons-night = "MoreWaita";
      x-wallpaper = false;
    };

    # file portals
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
    };

    "org/gtk/settings/file-chooser" = {
      show-hidden = true;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
    };

    # m/kb
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "pl"
        ])
      ];
    };

    # hotkeys
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      mic-mute = [ "<Control>m" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>r";
      command = "ptyxis --new-window";
      name = "Start terminal";
    };

    # night light
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
      night-light-last-coordinates = mkTuple [
        osConfig.location.latitude
        osConfig.location.longitude
      ];
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    # power management
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
      sleep-inactive-ac-timeout = 1200;
      sleep-inactive-ac-type = "suspend";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    # temporary files
    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };

    # extensions
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "bitwarden.desktop:1"
        "org.telegram.desktop.desktop:1"
        "vesktop.desktop:1"
        "Schizofox.desktop:2"
        "lunarclient.desktop:3"
        "org.prismlauncher.PrismLauncher.desktop:3"
        "slack.desktop:3"
        "timedoctor-desktop.desktop:3"
        "steam.desktop:4"
      ];
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-saturation = 1.0;
      legacy-tray-enabled = true;
    };

    "org/gnome/shell/extensions/caffeine" = {
      screen-blank = "always";
      show-notifications = false;
    };

    "org/gnome/shell/extensions/quick-settings-avatar" = {
      avatar-position = 1;
    };

    "org/gnome/shell/extensions/wintile-beyond" = {
      delay = 1000;
      distance = 25;
      use-minimize = false;
    };

    "org/gnome/shell/extensions/gamemodeshellextension" = {
      show-icon-only-when-active = true;
      show-launch-notification = false;
    };

    "org/gnome/shell/extensions/pip-on-top" = {
      stick = true;
    };

    # terminal/ptyxis
    "org/gnome/Ptyxis" = {
      cursor-shape = "ibeam";
      default-profile-uuid = "6558e70a00b73616061537c7663760c0";
      font-name = "Cascadia Mono PL 11";
      interface-style = "dark";
      profile-uuids = [ "6558e70a00b73616061537c7663760c0" ];
      restore-session = false;
      restore-window-size = false;
      use-system-font = false;
    };

    "org/gnome/Ptyxis/Profiles/6558e70a00b73616061537c7663760c0" = {
      label = "home-manager";
      scrollback-lines = 20000;
    };

    # random other gnome stuff
    "org/gnome/desktop/media-handling" = {
      autorun-never = true;
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    # virt-manager
    "org/virt-manager/virt-manager" = {
      xmleditor-enabled = true;
    };

    "org/virt-manager/virt-manager/console" = {
      auto-redirect = false;
    };

    "org/virt-manager/virt-manager/new-vm" = {
      cpu-default = "host-passthrough";
      firmware = "uefi";
      graphics-type = "system";
    };

    # random other software
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gnome/TextEditor" = {
      discover-settings = true;
      highlight-current-line = true;
      indent-style = "space";
      restore-session = false;
      show-line-numbers = true;
      tab-width = mkUint32 2;
      wrap-text = false;
    };

    "org/gnome/gitlab/cheywood/Buffer" = {
      font-size = 10;
    };
  };
}
