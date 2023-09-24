_: {
  services.microbin = {
    enable = true;
    settings = {
      MICROBIN_PUBLIC_PATH = "https://blahaj.pl/";
      MICROBIN_PORT = 9595;
      MICROBIN_FOOTER_TEXT = "Report illegal content to bin@nekopon.pl; Code: https://github.com/surfaceflinger/flake";
      MICROBIN_TITLE = "BlahajBin";
      MICROBIN_ENABLE_BURN_AFTER = true;
      MICROBIN_QR = true;
      MICROBIN_NO_FILE_UPLOAD = true;
      MICROBIN_ENCRYPTION_CLIENT_SIDE = true;
      MICROBIN_ENCRYPTION_SERVER_SIDE = true;
      MICROBIN_LIST_SERVER = false;
    };
  };

  services.caddy.virtualHosts."blahaj.pl".extraConfig = ''
    @replacePaths { path_regexp /static/(logo.png|water.css) }

    handle @replacePaths {
      rewrite /static/logo.png ${./blahaj.png}
      rewrite /static/water.css ${./water.css}
      file_server
    }

    reverse_proxy http://127.0.0.1:9595
  '';
}
