{
  perSystem =
    { pkgs, ... }:
    {
      packages.typst-package-check = pkgs.callPackage ./_package.nix { };
    };
}
