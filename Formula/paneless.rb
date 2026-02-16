class Paneless < Formula
  desc "Tiling window manager for macOS with virtual workspaces and smooth animations"
  homepage "https://github.com/DYNNIwav/paneless"
  head "https://github.com/DYNNIwav/paneless.git", branch: "master"
  license "MIT"

  depends_on :xcode => ["15.0", :build]
  depends_on :macos => :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/Paneless" => "paneless"

    # Create .app bundle
    app_dir = prefix/"Paneless.app/Contents"
    (app_dir/"MacOS").mkpath
    (app_dir/"Resources").mkpath

    cp bin/"paneless", app_dir/"MacOS/Paneless"
    cp buildpath/"Resources/Info.plist", app_dir/"Info.plist"

    if (buildpath/"Resources/AppIcon.icns").exist?
      cp buildpath/"Resources/AppIcon.icns", app_dir/"Resources/AppIcon.icns"
    end
  end

  def post_install
    app_target = Pathname.new("#{Dir.home}/Applications/Paneless.app")
    app_target.unlink if app_target.symlink? || app_target.exist?
    app_target.make_symlink(opt_prefix/"Paneless.app")
  end

  def caveats
    <<~EOS
      Paneless requires two permissions in System Settings > Privacy & Security:

        - Accessibility (to move and resize windows)
        - Input Monitoring (for global hotkeys)

      Paneless.app has been symlinked to ~/Applications.

      To start Paneless:
        open ~/Applications/Paneless.app

      To start at login:
        System Settings > General > Login Items > add Paneless

      Config file: ~/.config/paneless/config
      A default config is created on first launch.
    EOS
  end

  test do
    assert_match "Paneless", shell_output("#{bin}/paneless --help 2>&1", 0)
  end
end
