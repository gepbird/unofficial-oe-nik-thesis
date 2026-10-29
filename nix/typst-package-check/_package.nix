{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "typst-package-check";
  # the version the typst/packages lint CI uses
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "typst";
    repo = "package-check";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/JsXhqwqRyXnZDxZ8qnavns9VO81Ss2tmnl5uAj9A0Q=";
  };

  cargoHash = "sha256-7lpmevoAZ0pRTdpSx17IhhwdqhcVVsvoqHUci+Makf8=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    description = "Checks a Typst package like the typst/packages repository does";
    homepage = "https://github.com/typst/package-check";
    license = with lib.licenses; [
      asl20
      mit
    ];
    mainProgram = "typst-package-check";
  };
})
