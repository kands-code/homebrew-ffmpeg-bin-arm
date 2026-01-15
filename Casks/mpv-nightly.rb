cask "mpv-nightly" do
  version "v0.41.0-dev-g2007f5543-20978304864"
  macos_version = MacOS.version.major.to_i

  url "https://nightly.link/mpv-player/mpv/workflows/build/master/mpv-#{version}-macos-#{macos_version}-arm.zip"
  sha256 :no_check
  depends_on macos: ">= :sonoma"

  name "mpv"
  desc "a free, open source, and cross-platform media player"
  homepage "https://mpv.io/"
  livecheck do
    url "https://nightly.link/mpv-player/mpv/workflows/build/master"
    strategy :page_match do |page|
      match = page.match(/mpv-v?(\d+\.\d+\.\d+-dev-g[a-f0-9]+-\d+)-macos-#{macos_version}-arm\.zip/i)
      next if match.blank?
      match[1]
    end
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
