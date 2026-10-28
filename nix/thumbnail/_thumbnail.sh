# renders the cover page of the starter project, as `typst init` creates it, to thumbnail.png in the repository

root=$(git rev-parse --show-toplevel)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# the repository as the published package, like in the dev shell
mkdir -p "$work/packages/preview/$PACKAGE_NAME"
ln -s "$root" "$work/packages/preview/$PACKAGE_NAME/$PACKAGE_VERSION"

# its success message points to the temporary folder, so it's only shown on failure
if ! output=$(typst init --package-path "$work/packages" "@preview/$PACKAGE_NAME:$PACKAGE_VERSION" "$work/project" 2>&1); then
  echo "$output" >&2
  exit 1
fi

typst compile --package-path "$work/packages" --pages 1 --ppi 250 "$work/project/main.typ" "$root/thumbnail.png"
oxipng --opt max --strip safe --quiet "$root/thumbnail.png"

# Typst Universe's limit
size=$(stat -c %s "$root/thumbnail.png")
if ((size > 3 * 1024 * 1024)); then
  echo "thumbnail.png is $size bytes, over the 3 MiB limit" >&2
  exit 1
fi
