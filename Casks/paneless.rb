cask "paneless" do
  version "0.7.0"
  sha256 "61ac459205141c619ad4433b19ce7047de176c2d6da54bc419bc7589a1cd52df"

  url "https://github.com/DYNNIwav/paneless/releases/download/v#{version}/Paneless-20260930.142632.zip"
  name "Paneless"
  desc "Tiling window manager with virtual workspaces and smooth animations"
  homepage "https://github.com/DYNNIwav/paneless"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Paneless.app"
  binary "#{appdir}/Paneless.app/Contents/MacOS/Paneless", target: "paneless"

  caveats <<~EOS
    Grant two permissions in System Settings > Privacy & Security:
      - Accessibility (to move and resize windows)
      - Input Monitoring (for global hotkeys)

    Config file: ~/.config/paneless/config (created on first launch)
  EOS
end
