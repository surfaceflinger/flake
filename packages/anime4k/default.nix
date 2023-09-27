{ stdenv
, fetchzip
}:
stdenv.mkDerivation rec {
  pname = "Anime4k";
  version = "4.0.1";

  src = fetchzip {
    url = "https://github.com/bloc97/Anime4K/releases/download/v4.0.1/Anime4K_v4.0.zip";
    sha512 = "R836y/N8OW9bWv2VFqppObsGEuNHoZWIzcwCO5co9qyjsAMJINKyzJI8G1KbTKWuQhh3C618QOE8V5DB1uMTAA==";
    stripRoot = false;
  };

  installPhase = ''
    find . -type f -iname '*.glsl' -exec install -Dm 644 {} -t $out \;
  '';
}
