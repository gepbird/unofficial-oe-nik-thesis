{ lib, ... }:

let
  package = (lib.importTOML ../../typst.toml).package;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      # the files to upload: `<name>/<version>/` to copy into the typst/packages repository and the same folder in
      # a zip for the GitHub release
      packages.bundle =
        pkgs.runCommand "${package.name}-${package.version}-bundle" { nativeBuildInputs = [ pkgs.zip ]; }
          ''
            mkdir -p $out/${package.name}
            cp -r ${self'.packages.default}/lib/typst-packages/${package.name}/${package.version} $out/${package.name}
            cd $out
            # writable when extracted, and a reproducible zip: fixed dates and order
            chmod -R u+w ${package.name}
            find ${package.name} -exec touch --date=@$SOURCE_DATE_EPOCH {} +
            find ${package.name} | sort | zip -q -X ${package.name}-${package.version}.zip -@
          '';
    };
}
