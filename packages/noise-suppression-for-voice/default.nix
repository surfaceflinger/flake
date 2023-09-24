{
  alsa-lib,
  at-spi2-core,
  cmake,
  curl,
  dbus,
  fetchFromGitHub,
  freetype,
  gtk3-x11,
  lib,
  libdatrie,
  libepoxy,
  libpsl,
  libselinux,
  libsepol,
  libsysprof-capture,
  libthai,
  libxkbcommon,
  pcre,
  pkg-config,
  sqlite,
  stdenv,
  util-linux,
  vtk,
  webkitgtk,
  xorg,
  ...
}:
stdenv.mkDerivation rec {
  pname = "noise-suppression-for-voice";
  version = "c1cf4307c75abed8e3ecccdd23a35f7782feaf69";

  src = fetchFromGitHub {
    owner = "werman";
    repo = pname;
    rev = version;
    hash = "sha256-1/HvGzk/WhzZ7Jg5bsRSV/dKZRSwYdvQCCqgXpIOgNs=";
  };

  nativeBuildInputs = [cmake pkg-config];
  buildInputs = [
    alsa-lib
    at-spi2-core
    curl
    dbus
    freetype
    gtk3-x11
    libdatrie
    libepoxy
    libpsl
    libselinux
    libsepol
    libsysprof-capture
    libthai
    libxkbcommon
    pcre
    sqlite
    util-linux
    vtk
    webkitgtk
    xorg.libX11
    xorg.libXcursor
    xorg.libXdmcp
    xorg.libXext
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXtst
  ];

  meta = with lib; {
    description = "Noise suppression plugin based on Xiph's RNNoise";
    homepage = "https://github.com/werman/noise-suppression-for-voice";
    license = licenses.gpl3;
  };
}
