{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    typstyle = {
      enable = true;
      lineWidth = 120;
    };
    shfmt.enable = true;
  };
}
