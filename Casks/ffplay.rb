cask "ffplay" do
  version "7.1"
  sha256 "17ce1e381e2bd60bea743280c5d7dd0a1698a9b355a34a4b0b08b0aec353b00e"

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
