cask "paneless" do
  version "0.8.0"
  sha256 "dd91f273ab08246304e7430b28f47eecefdde9355ed5f2d8b4dcffbe240b015d"
  url "https://github.com/DYNNIwav/paneless/releases/download/v0.8.0/Paneless-20261006.083814.zip"
  name "Paneless"
  desc "Tiling window manager"
  homepage "https://github.com/DYNNIwav/paneless"
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma
  app "Paneless.app"
  binary "#{appdir}/Paneless.app/Contents/MacOS/Paneless", target: "paneless"
end
