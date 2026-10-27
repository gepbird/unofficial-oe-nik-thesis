{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { pkgs, self', ... }:
        {
          packages.nimbus = pkgs.callPackage ./nix/nimbus.nix { };

          devShells.default = pkgs.callPackage ./nix/dev-shell.nix { inherit (self'.packages) nimbus; };
        };
    };
}
