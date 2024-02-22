# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "io/bassi/Amberol" = {
      replay-gain = "track";
    };

    "com/raggesilver/BlackBox" = {
      font = "Cascadia Code PL 11";
      headerbar-drag-area = true;
      pretty = false;
      show-headerbar = true;
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
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/media-handling" = {
      autorun-never = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
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

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "suspend";
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
    };

    "org/gnome/nautilus/icon-view" = {
      captions = [
        "date_modified"
        "size"
        "none"
      ];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      mic-mute = [ "<Control>m" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>r";
      command = "blackbox";
      name = "Start terminal";
    };

    "org/gnome/shell" = {
      app-picker-layout = [ "" ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "com.raggesilver.BlackBox.desktop"
        "google-chrome.desktop"
        "google-chrome-beta.desktop"
        "google-chrome-unstable.desktop"
        "org.telegram.desktop.desktop"
        "discord.desktop"
        "discord-canary.desktop"
        "vesktop.desktop"
        "armcord.desktop"
        "slack.desktop"
        "org.gnome.Fractal.desktop"
        "org.squidowl.halloy.desktop"
        "timedoctor-desktop.desktop"
        "org.gnome.Geary.desktop"
        "org.gnome.Lollypop.desktop"
        "io.bassi.Amberol.desktop"
        "code.desktop"
        "io.gitlab.news_flash.NewsFlash.desktop"
        "org.gabmus.gfeeds.desktop"
        "org.prismlauncher.PrismLauncher.desktop"
        "lunar-client.desktop"
        "steam.desktop"
        "pavucontrol.desktop"
        "com.github.wwmm.easyeffects.desktop"
        "virt-manager.desktop"
        "transmission-gtk.desktop"
        "org.qbittorrent.qBittorrent.desktop"
        "ledger-live-desktop.desktop"
        "bitwarden.desktop"
      ];
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-saturation = 1.0;
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "discord.desktop:1"
        "org.telegram.desktop.desktop:1"
        "google-chrome.desktop:2"
        "org.prismlauncher.PrismLauncher.desktop:3"
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

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
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
      resize-guest = 1;
    };

    "org/virt-manager/virt-manager/new-vm" = {
      cpu-default = "host-passthrough";
      graphics-type = "system";
    };
  };
}
