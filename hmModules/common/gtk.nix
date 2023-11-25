{ ... }: {
  imports = [ ./dconf.nix ];

  gtk = {
    enable = true;
    gtk3.extraCss = builtins.readFile ./gtk.css;
    gtk4.extraCss = builtins.readFile ./gtk.css;
  };
}
