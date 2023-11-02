{ blueprint-compiler
, desktop-file-utils
, fetchFromGitHub
, lib
, libadwaita
, libportal-gtk4
, libsoup_3
, meson
, ninja
, pkg-config
, python3Packages
, wrapGAppsHook4
}:

python3Packages.buildPythonApplication rec {
  pname = "gradience-git";
  version = "unstable-2023-10-30";

  src = fetchFromGitHub {
    owner = "GradienceTeam";
    repo = "Gradience";
    rev = "7826b4fc6357ac66f6550a74f32ef8ceb56b93d7";
    sha256 = "sha256-O6HE8O5jfOUChZVCs9rLRaU37vr2yV4J9PP3R0xQ+EE=";
    fetchSubmodules = true;
  };

  patches = [
    ./shell-settings.patch
    ./assert-write-permissions-on-gnome-shell-copy.patch
  ];

  format = "other";

  nativeBuildInputs = [
    blueprint-compiler
    desktop-file-utils
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    blueprint-compiler
    libadwaita
    libportal-gtk4
    libsoup_3
  ];

  propagatedBuildInputs = with python3Packages; [
    anyascii
    lxml
    material-color-utilities
    pygobject3
    python3Packages.libsass
    svglib
    yapsy
  ];

  meta = with lib; {
    description = "Customize libadwaita and GTK3 apps (with adw-gtk3)";
    homepage = "https://github.com/GradienceTeam/Gradience";
    license = licenses.gpl3Plus;
    mainProgram = "gradience";
  };
}
