{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.default = pkgs.callPackage ./_package.nix { };

      # Typst with the package and the packages it imports, in its package cache
      packages.typst = pkgs.typst.withPackages (_: [ self'.packages.default ]);
    };
}
