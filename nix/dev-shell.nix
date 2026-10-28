{
  perSystem =
    { pkgs, self', ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          typst
          typstyle
          tinymist
        ];

        env.TYPST_FONT_PATHS = "${self'.packages.nimbus}/share/fonts";

        shellHook = ''
          # fix typst display 1980 for datetime.today()
          unset SOURCE_DATE_EPOCH
        '';
      };
    };
}
