cask "ffplay" do
  version "7.0"
  sha256 "d2bee00e6765649fc201814610dbf6932bb4eb3b2964c7c008534c0ba2cb97c0"

  url "https://www.osxexperts.net/ffplay#{version.major}arm.zip", verified: "osxexperts.net/"
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
