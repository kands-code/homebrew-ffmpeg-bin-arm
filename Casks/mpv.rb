cask "mpv" do
  version "nightly"

  macos_version = MacOS.version.to_s.split('.').first.to_i

  url 'https://nightly.link/mpv-player/mpv/workflows/build/master/mpv-macos-#{macos_version}-arm.zip'
  sha256 :no_check
  name "mpv"
  desc "a free, open source, and cross-platform media player"
  homepage "https://mpv.io/"
  
  livecheck do
    url "https://nightly.link/mpv-player/mpv/workflows/build/master/"
    regex(/href=.*?mpv-macos-(\d+)-arm\.zip/i)
  end
  
  depends_on macos: ">= :sonoma"

  binary "mpv"

  conflicts_with cask: [ 'stolendata-mpv' ]

  caveats <<~EOS
    For macOS 10.15 (Catalina) or higher you need to remove the file from quarantine.
    You can do this in the Terminal:
    
      xattr -cr #{staged_path}/#{token} && codesign -s - #{staged_path}/#{token}

    For Nushell:

      do --capture-errors {
        ^xattr -cr #{staged_path}/#{token}
      } | ^codesign -s - #{staged_path}/#{token}
  EOS
end
  