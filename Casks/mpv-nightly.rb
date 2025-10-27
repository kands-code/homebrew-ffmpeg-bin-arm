cask "mpv-nightly" do
  version "nightly"

  macos_version = [MacOS.version.to_s.split('.').first.to_i, 15].min # no builds for macOS 26

  url "https://nightly.link/mpv-player/mpv/workflows/build/master/mpv-macos-#{macos_version}-arm.zip"
  sha256 :no_check
  depends_on macos: ">= :sonoma"

  name "mpv"
  desc "a free, open source, and cross-platform media player"
  homepage "https://mpv.io/"
  livecheck do
    url :url
    strategy :header_match
  end

  app "mpv.app"
  binary "#{appdir}/mpv.app/Contents/MacOS/mpv"
  conflicts_with cask: [ 'stolendata-mpv' ]

  caveats <<~EOS
    For macOS 10.15 (Catalina) or higher you need to remove the file from quarantine.
    You can do this in the Terminal:

      xattr -cr #{appdir}/mpv.app

    For Nushell:

      ^xattr -cr #{appdir}/mpv.app
  EOS
end
