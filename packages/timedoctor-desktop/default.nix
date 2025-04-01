{ pkgs, ... }:
let
  pname = "timedoctor-desktop";
  version = "3.12.16";

  src = pkgs.fetchurl {
    url = "https://repo2.timedoctor.com/td-desktop-hybrid/prod/v${version}/timedoctor-desktop_${version}_linux-x86_64.AppImage";
    hash = "sha256-EodbUs88REwa3JMy2/reHcxLwvNaPtVKZDIkLPd11BU=";
  };
  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit pname version src;

  extraBwrapArgs = [
    "--tmpfs /dev"
    "--dev-bind /dev/null /dev/null"
    "--dev-bind /dev/shm /dev/shm"
    "--dev-bind /dev/urandom /dev/urandom"
    "--tmpfs /boot"
    "--tmpfs /home"
    "--bind $HOME/.config/Time\\ Doctor $HOME/.config/Time\\ Doctor"
    "--tmpfs /persist"
    "--tmpfs /sys"
    "--tmpfs /tmp"
    "--tmpfs /var"
    "--tmpfs /vol"
    "--unshare-pid"
    "--setenv LD_PRELOAD ${pkgs.graphene-hardened-malloc}/lib/libhardened_malloc.so"
  ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/timedoctor-desktop.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/timedoctor-desktop.png -t $out/share/pixmaps
    substituteInPlace $out/share/applications/timedoctor-desktop.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=timedoctor-desktop'
    source "${pkgs.makeWrapper}/nix-support/setup-hook"
    wrapProgram "$out/bin/timedoctor-desktop" \
      --add-flags "--disable-gpu --disable-accelerated-video-encode --disable-features=VizDisplayCompositor" \
      --add-flags "--js-flags=--jitless"
  '';

  extraPkgs =
    _: with _; [
      (libjpeg.override { enableJpeg8 = true; })
      lz4
    ];

  meta = with pkgs.lib; {
    description = "Employee time tracking software (Time Doctor Classic)";
    homepage = "https://www.timedoctor.com";
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ surfaceflinger ];
  };
}
