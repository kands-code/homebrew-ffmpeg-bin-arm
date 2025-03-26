cask "ffplay" do
  version "7.1.1"
  sha256 "a29c1a22763b7eae295f264690130e5f1d6fc1b21addd6277e55099d309a0ae2"

  url "https://www.osxexperts.net/ffplay#{version.no_dots}arm.zip", verified: "osxexperts.net/"
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
