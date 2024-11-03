{ perSystem, pkgs, ... }:
{
  imports = [ ./dconf.nix ];

  gtk = {
    enable = true;
    gtk3.extraCss = builtins.readFile ./gtk.css;
    cursorTheme = {
      name = "miku-cursor";
      package = perSystem.self.miku-cursor;
    };
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; }
      { package = auto-move-windows; }
      { package = caffeine; }
      { package = luminus-shell; }
      { package = pip-on-top; }
      { package = tailscale-qs; }
      { package = user-avatar-in-quick-settings; }
      { package = user-themes-x; }
      { package = window-is-ready-remover; }
    ];
  };
}
