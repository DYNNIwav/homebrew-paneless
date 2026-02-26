cask "paneless" do
  version "1.3.0"
  sha256 "46e4c0699b4e8cb3f9e95c77b72aaeb923995fae56d162ef52a95051903f1322"

  url "https://github.com/DYNNIwav/paneless/releases/download/v#{version}/Paneless.app.zip"
  name "Paneless"
  desc "Tiling window manager for macOS with virtual workspaces and smooth animations"
  homepage "https://github.com/DYNNIwav/paneless"

  depends_on macos: ">= :sonoma"

  app "Paneless.app"
  binary "#{appdir}/Paneless.app/Contents/MacOS/Paneless", target: "paneless"

  caveats <<~EOS
    Grant two permissions in System Settings > Privacy & Security:
      - Accessibility (to move and resize windows)
      - Input Monitoring (for global hotkeys)

    Config file: ~/.config/paneless/config (created on first launch)
  EOS
end
