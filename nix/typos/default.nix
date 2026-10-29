{ self, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      # spell check of the whole repository, with the exceptions in `_typos.toml`
      checks.typos = pkgs.runCommand "typos" { nativeBuildInputs = [ pkgs.typos ]; } ''
        cd ${self}
        typos
        touch $out
      '';
    };
}
