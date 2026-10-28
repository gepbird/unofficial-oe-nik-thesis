{
  perSystem =
    { pkgs, ... }:
    {
      packages.nimbus = pkgs.callPackage ./_package.nix { };
    };
}
