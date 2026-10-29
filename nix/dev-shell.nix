{ lib, ... }:

let
  package = (lib.importTOML ../typst.toml).package;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          typst
          typstyle
          tinymist
          self'.packages.typst-package-check
          tytanic
          typos
          self'.packages.thumbnail
        ];

        env.TYPST_FONT_PATHS = "${self'.packages.nimbus}/share/fonts";

        shellHook = ''
          # fix typst display 1980 for datetime.today()
          unset SOURCE_DATE_EPOCH

          # for testing the template that imports this package from @preview
          root=$(git rev-parse --show-toplevel)
          export TYPST_PACKAGE_PATH="/tmp/typst-packages-$(echo "$root" | sha256sum | head -c 16)"
          mkdir -p "$TYPST_PACKAGE_PATH/preview/${package.name}"
          ln -sfn "$root" "$TYPST_PACKAGE_PATH/preview/${package.name}/${package.version}"
        '';
      };
    };
}
