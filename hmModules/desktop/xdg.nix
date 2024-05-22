_:
let
  browser = [ "Schizofox.desktop" ];

  associations = {
    "application/json" = browser;
    "application/pdf" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "audio/*" = [ "io.bassi.Amberol.desktop" ];
    "image/*" = [ "org.gnome.Loupe.desktop" ];
    "video/*" = [ "mpv.desktop" ];

    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  };
in
{
  xdg.mimeApps = {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
