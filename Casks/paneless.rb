cask "paneless" do
  version "0.5.1"
  sha256 "76d957683fa18a499a6459f2abcfb637a0f5303b8cfffcc925d70fda78033d59"

  url "https://github.com/DYNNIwav/paneless/releases/download/v#{version}/Paneless.app.zip"
  name "Paneless"
  desc "Tiling window manager for macOS with virtual workspaces and smooth animations"
  homepage "https://github.com/DYNNIwav/paneless"

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
