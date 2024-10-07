cask "ffplay" do
  version "7.1"
  sha256 "d7a17b7f1ea9de2136638b1679b2eca06e4d945d57ae6d9c33f185537a284cd4"

  url "https://www.osxexperts.net/ffplay#{version.major}#{version.minor}arm.zip", verified: "osxexperts.net/"
  name "ffplay"
  desc "Complete, cross-patform solution to convert audio and video"
  homepage "https://ffmpeg.org/"

  livecheck do
    url "https://www.osxexperts.net/"
    regex(/href=.*?ffplay(\d+)arm\.zip/i)
  end

  depends_on macos: ">= :monterey"

  binary "ffplay"

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
