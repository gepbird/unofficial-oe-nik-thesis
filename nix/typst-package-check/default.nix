{ lib, ... }:

let
  package = (lib.importTOML ../../typst.toml).package;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.typst-package-check = pkgs.callPackage ./_package.nix { };

      checks.typst-package-check =
        pkgs.runCommand "typst-package-check"
          {
            nativeBuildInputs = [ self'.packages.typst-package-check ];
            # the package and the packages it imports in Typst's package cache, where the check looks for them
            XDG_CACHE_HOME = "${self'.packages.typst}/lib";
          }
          ''
            cd ${self'.packages.default}/lib/typst-packages/${package.name}/${package.version}
            # the sandbox has no network access, this only skips checking that the `repository` URL works
            typst-package-check check --offline
            touch $out
          '';
    };
}
