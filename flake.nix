{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [ ./nix/treefmt.nix ];

      perSystem =
        { pkgs, self', ... }:
        {
          packages.nimbus = pkgs.callPackage ./nix/nimbus.nix { };

          devShells.default = pkgs.callPackage ./nix/dev-shell.nix { inherit (self'.packages) nimbus; };
        };
    };
}
