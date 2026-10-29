{
  lib,
  buildTypstPackage,
  typstPackages,
}:

let
  package = (lib.importTOML ../../typst.toml).package;
in
# the package's files with the packages it imports, from nixpkgs like the rest
buildTypstPackage {
  pname = package.name;
  inherit (package) version;
  src = lib.fileset.toSource {
    root = ../..;
    fileset = lib.fileset.unions [
      ../../typst.toml
      ../../lib.typ
      ../../src
      ../../template
      ../../README.md
      ../../LICENSE
      ../../thumbnail.png
    ];
  };
  typstDeps = with typstPackages; [
    glossarium
    wordometer
  ];
}
