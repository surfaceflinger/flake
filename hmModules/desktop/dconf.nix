# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/Ptyxis" = {
      cursor-shape = "ibeam";
      default-profile-uuid = "6558e70a00b73616061537c7663760c0";
      font-name = "Cascadia Mono PL 11";
      profile-uuids = [ "6558e70a00b73616061537c7663760c0" ];
      restore-session = false;
      restore-window-size = false;
      use-system-font = false;
    };

    "org/gnome/Ptyxis/Profiles/6558e70a00b73616061537c7663760c0" = {
      label = "home-manager";
      scrollback-lines = 20000;
    };

    "org/gnome/Connections" = {
      first-run = false;
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

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "" ];
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "pl"
        ])
      ];
    };

    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      document-font-name = "Inter Variable 11";
      font-hinting = "none";
      font-name = "Inter Variable 11";
      gtk-enable-primary-paste = false;
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus";
      monospace-font-name = "Cascadia Mono PL 10";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/media-handling" = {
      autorun-never = true;
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
      experimental-features = [ "variable-refresh-rate" ];
      workspaces-only-on-primary = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 22.0;
    };

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

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "nothing";
      sleep-inactive-ac-timeout = 1200;
      sleep-inactive-ac-type = "suspend";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
    };

    "org/gnome/shell" = {
      disable-extension-version-validation = true;
      app-picker-layout = [ "" ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "quick-settings-avatar@d-go"
        "tailscale@joaophi.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "windowIsReady_Remover@nunofarruca@gmail.com"
      ];
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
        "lunar-client.desktop"
        "steam.desktop"
        "pavucontrol.desktop"
        "com.github.wwmm.easyeffects.desktop"
        "virt-manager.desktop"
        "de.haeckerfelix.Fragments.desktop"
        "org.qbittorrent.qBittorrent.desktop"
        "bitwarden.desktop"
      ];
      welcome-dialog-last-shown-version = "46.1";
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-saturation = 1.0;
      legacy-tray-enabled = false;
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "bitwarden.desktop:1"
        "discord.desktop:1"
        "org.telegram.desktop.desktop:1"
        "google-chrome.desktop:2"
        "org.prismlauncher.PrismLauncher.desktop:3"
        "slack.desktop:3"
        "timedoctor-desktop.desktop:3"
        "steam.desktop:4"
      ];
    };

    "org/gnome/shell/extensions/caffeine" = {
      screen-blank = "always";
      show-notifications = false;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "gradience-shell";
    };

    "org/gnome/shell/extensions/quick-settings-avatar" = {
      avatar-position = 1;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

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

    "org/virt-manager/virt-manager" = {
      xmleditor-enabled = true;
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [
        "qemu:///system"
        "lxc:///"
      ];
      uris = [
        "lxc:///"
        "qemu:///system"
      ];
    };

    "org/virt-manager/virt-manager/console" = {
      auto-redirect = false;
    };

    "org/virt-manager/virt-manager/new-vm" = {
      cpu-default = "host-passthrough";
      firmware = "uefi";
      graphics-type = "system";
    };
  };
}
