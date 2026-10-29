{
  lib,
  buildTypstPackage,
  fetchzip,
  typstPackages,
}:

let
  package = (lib.importTOML ../../typst.toml).package;

  # nixpkgs only has wordometer 0.1.5
  wordometer =
    lib.warnIf (lib.versionAtLeast typstPackages.wordometer.version "0.1.6")
      "nixpkgs has wordometer ${typstPackages.wordometer.version}, remove the override in nix/package/_package.nix"
      (
        typstPackages.wordometer.overrideAttrs (
          finalAttrs: prev: {
            version = "0.1.6";
            src = fetchzip {
              url = "https://packages.typst.org/preview/wordometer-${finalAttrs.version}.tar.gz";
              hash = "sha256-+lh7dA6fUZyeTVZuU8sZZDOlWbzo7+Q+4NIX8z37Uts=";
              stripRoot = false;
            };
            # 0.1.5 depends on tidy, 0.1.6 doesn't import any package
            propagatedBuildInputs = [ ];
            passthru = prev.passthru // {
              typstDeps = [ ];
            };
          }
        )
      );
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
