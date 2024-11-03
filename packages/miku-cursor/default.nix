{ pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  name = "miku-cursor";
  version = "1.2.4";

  src = pkgs.fetchFromGitHub {
    owner = "supermariofps";
    repo = "hatsune-miku-windows-linux-cursors";
    rev = "${finalAttrs.version}";
    hash = "sha256-PB8b/hGH5HtCEPOVPTtObWYOj520TqBpoxavA8Tfx2s=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    mv miku-cursor-linux miku-cursor
    cp -R miku-cursor $out/share/icons/

    runHook postInstall
  '';
  meta = with pkgs.lib; {
    platforms = platforms.linux;
    maintainers = with maintainers; [ cafkafk ];
  };
})
