{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

  gtk = {
    enable = true;
    gtk4.extraCss = builtins.readFile "${pkgs.graphite-gtk-theme}/share/themes/Graphite-pink-Dark/gtk-4.0/gtk.css";
  };
}
