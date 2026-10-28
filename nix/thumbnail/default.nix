{ lib, ... }:

let
  package = (lib.importTOML ../../typst.toml).package;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.thumbnail = pkgs.writeShellApplication {
        name = "thumbnail";
        runtimeInputs = with pkgs; [
          coreutils
          git
          oxipng
          typst
        ];
        runtimeEnv = {
          PACKAGE_NAME = package.name;
          PACKAGE_VERSION = package.version;
          TYPST_FONT_PATHS = "${self'.packages.nimbus}/share/fonts";
        };
        text = builtins.readFile ./_thumbnail.sh;
      };
    };
}
