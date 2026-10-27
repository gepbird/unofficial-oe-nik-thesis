{
  mkShell,
  typst,
  typstyle,
  tinymist,
  nimbus,
}:

mkShell {
  packages = [
    typst
    typstyle
    tinymist
  ];

  env.TYPST_FONT_PATHS = "${nimbus}/share/fonts";

  shellHook = ''
    # fix typst display 1980 for datetime.today()
    unset SOURCE_DATE_EPOCH
  '';
}
