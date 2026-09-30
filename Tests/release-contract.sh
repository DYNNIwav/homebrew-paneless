#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
cask=Casks/paneless.rb
ruby -c "$cask"
version="$(sed -n 's/^  version "\([^"]*\)"/\1/p' "$cask")"
sha="$(sed -n 's/^  sha256 "\([^"]*\)"/\1/p' "$cask")"
url="$(sed -n 's/^  url "\([^"]*\)"/\1/p' "$cask")"
url="${url//\#\{version\}/$version}"
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
[[ "$sha" =~ ^[0-9a-f]{64}$ ]]
[[ "$url" == https://github.com/DYNNIwav/paneless/releases/download/v"$version"/Paneless-*.zip ]]
rg -Fxq '  auto_updates true' "$cask"
rg -Fxq '  depends_on arch: :arm64' "$cask"
rg -Fxq '  depends_on macos: :sonoma' "$cask"
rg -Fxq '  app "Paneless.app"' "$cask"
rg -Fxq '  binary "#{appdir}/Paneless.app/Contents/MacOS/Paneless", target: "paneless"' "$cask"
fixture="$(mktemp -d /private/tmp/paneless-tap-contract.XXXXXX)"
trap 'rm -rf "$fixture"' EXIT
curl --fail --silent --show-error --location "$url" -o "$fixture/release.zip"
test "$(shasum -a 256 "$fixture/release.zip" | awk '{print $1}')" = "$sha"
curl --fail --silent --show-error --location "https://github.com/DYNNIwav/paneless/releases/download/v$version/appcast.xml" -o "$fixture/appcast.xml"
test "$(xmllint --xpath 'string(//*[local-name()="enclosure"]/@url)' "$fixture/appcast.xml")" = "$url"
test "$(xmllint --xpath 'string(//*[local-name()="enclosure"]/@length)' "$fixture/appcast.xml")" = "$(stat -f %z "$fixture/release.zip")"
test "$(xmllint --xpath 'string(//*[local-name()="item"]/*[local-name()="shortVersionString"])' "$fixture/appcast.xml")" = "$version"
test -n "$(xmllint --xpath 'string(//*[local-name()="enclosure"]/@*[local-name()="edSignature"])' "$fixture/appcast.xml")"
ditto -x -k "$fixture/release.zip" "$fixture"
codesign --verify --deep --strict "$fixture/Paneless.app"
xcrun stapler validate "$fixture/Paneless.app"
spctl --assess --type execute "$fixture/Paneless.app"
echo "Published Paneless cask, checksum, Sparkle feed, signature, and notarization contracts passed"
