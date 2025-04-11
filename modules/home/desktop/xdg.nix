_:
let
  browser = [ "Schizofox.desktop" ];
  docs = [ "org.gnome.Papers.desktop" ];
  music = [ "io.bassi.Amberol.desktop" ];
  photos = [ "org.gnome.Loupe.desktop" ];
  steam = [ "steam.desktop" ];
  text = [ "org.gnome.TextEditor.desktop" ];
  vids = [ "mpv.desktop" ];

  associations = {
    # misc
    "application/json" = browser;
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

    # apps
    "x-scheme-handler/discord" = [ "vesktop.desktop" ];
    "x-scheme-handler/slack" = [ "slack.desktop" ];
    "x-scheme-handler/steamlink" = steam;
    "x-scheme-handler/steam" = steam;
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];

    # audio formats
    "audio/aac" = music;
    "audio/flac" = music;
    "audio/mpeg" = music;
    "audio/ogg" = music;
    "audio/opus" = music;
    "audio/wav" = music;
    "audio/x-ms-wma" = music;

    # image formats
    "image/avif" = photos;
    "image/bmp" = photos;
    "image/gif" = photos;
    "image/heic" = photos;
    "image/jpeg" = photos;
    "image/png" = photos;
    "image/svg+xml" = photos;
    "image/tiff" = photos;
    "image/webp" = photos;
    "image/x-icon" = photos;

    # video formats
    "video/mp4" = vids;
    "video/ogg" = vids;
    "video/quicktime" = vids;
    "video/webm" = vids;
    "video/x-matroska" = vids;
    "video/x-msvideo" = vids;
    "video/x-ms-wmv" = vids;

    # docs
    "application/pdf" = docs;
    "text/csv" = text;
  };
in
{
  xdg.mimeApps = {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
