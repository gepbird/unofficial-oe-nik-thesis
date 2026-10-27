{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  installFonts,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "nimbus";
  version = "20200910";

  src = fetchFromGitHub {
    owner = "ArtifexSoftware";
    repo = "urw-base35-fonts";
    tag = finalAttrs.version;
    hash = "sha256-YQl5IDtodcbTV3D6vtJi7CwxVtHHl58fG6qCAoSaP4U=";
  };

  nativeBuildInputs = [ installFonts ];

  postPatch = ''
    find fonts -type f ! -name 'NimbusRoman-*.ttf' ! -name 'NimbusSans-*.ttf' -delete
  '';

  meta = {
    description = "Nimbus Roman and Nimbus Sans fonts from the URW++ base 35 fonts, alternatives to Times New Roman and Arial";
    homepage = "https://github.com/ArtifexSoftware/urw-base35-fonts";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ gepbird ];
  };
})
