cask "paneless" do
  version "1.0.0"
  sha256 "26e41b6e7982f6b994cce291f6256db522226e192fd4ec0928757a92c98f45e8"

  url "https://github.com/DYNNIwav/paneless/releases/download/v#{version}/Paneless.app.zip"
  name "Paneless"
  desc "Tiling window manager for macOS with virtual workspaces and smooth animations"
  homepage "https://github.com/DYNNIwav/paneless"

  depends_on macos: ">= :sonoma"

  app "Paneless.app"
  binary "#{appdir}/Paneless.app/Contents/MacOS/Paneless", target: "paneless"

  caveats <<~EOS
    Paneless is not code-signed. To allow it to run:
      sudo xattr -cr /Applications/Paneless.app

    Then grant two permissions in System Settings > Privacy & Security:
      - Accessibility (to move and resize windows)
      - Input Monitoring (for global hotkeys)

    Config file: ~/.config/paneless/config (created on first launch)
  EOS
end
