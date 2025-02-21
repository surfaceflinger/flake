{ pkgs }:
let
  safe-rm = pkgs.safe-rm.overrideAttrs (old: {
    patches = old.patches ++ [
      ./paths.patch
    ];
  });
in
pkgs.symlinkJoin {
  name = "safe-rm";
  paths = [ safe-rm ];
  postBuild = ''
    ln -s ${safe-rm}/bin/safe-rm $out/bin/rm
  '';
}
