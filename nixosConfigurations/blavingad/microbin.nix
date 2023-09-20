_: {
  services.microbin = {
    enable = true;
    urls.publicPath = "https://blahaj.pl/";
    port = 9595;
    footer.text = "Report illegal content to bin@nekopon.pl; Code: https://github.com/surfaceflinger/flake";
    header.title = "BlahajBin";
    burn.enable = true;
    qr = true;
    disableFileUpload = true;
    encryption = {
      clientSide = true;
      serverSide = true;
    };
    listServer = true;
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
