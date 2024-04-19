{
  bash,
  fetchFromGitHub,
  gawk,
  git,
  lib,
  makeWrapper,
  procps,
  stdenv,
  unixtools,
  unzip,
  wget,
  xdotool,
  xorg,
  yad,
}:

stdenv.mkDerivation rec {
  pname = "steamtinkerlaunch";
  version = "0-unstable-2024-04-14";

  src = fetchFromGitHub {
    owner = "sonic2kk";
    repo = pname;
    rev = "109c6f3e86db7fe324dc665e69788b07890bb46f";
    hash = "sha256-X5B2jYzTMnqHuxH+SWohRUaJ8AbvPKa5R8ZBKx3iGME=";
  };

  # hardcode PROGCMD because #150841
  postPatch = ''
    substituteInPlace steamtinkerlaunch --replace 'PROGCMD="''${0##*/}"' 'PROGCMD="steamtinkerlaunch"'
  '';

  nativeBuildInputs = [ makeWrapper ];

  installFlags = [ "PREFIX=\${out}" ];

  postInstall = ''
    wrapProgram $out/bin/steamtinkerlaunch --prefix PATH : ${
      lib.makeBinPath [
        bash
        gawk
        git
        procps
        unixtools.xxd
        unzip
        wget
        xdotool
        xorg.xprop
        xorg.xrandr
        xorg.xwininfo
        yad
      ]
    }
  '';

  meta = with lib; {
    description = "Linux wrapper tool for use with the Steam client for custom launch options and 3rd party programs";
    mainProgram = "steamtinkerlaunch";
    homepage = "https://github.com/sonic2kk/steamtinkerlaunch";
    license = licenses.gpl3;
    maintainers = with maintainers; [ urandom ];
    platforms = lib.platforms.linux;
  };
}
