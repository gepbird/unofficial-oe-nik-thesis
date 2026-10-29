{ lib, ... }:

let
  package = (lib.importTOML ../../typst.toml).package;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      # smoke test: the starter project in `template/` compiles with the Nimbus fonts, without warnings
      checks.tytanic =
        pkgs.runCommand "tytanic"
          {
            nativeBuildInputs = [ pkgs.tytanic ];
            # the packages the package imports in Typst's package cache
            XDG_CACHE_HOME = "${self'.packages.typst}/lib";
          }
          ''
            cd ${self'.packages.default}/lib/typst-packages/${package.name}/${package.version}
            # a missing font is only a warning, promoted to an error
            tt run --warnings promote --font-path ${self'.packages.nimbus}/share/fonts
            touch $out
          '';
    };
}
