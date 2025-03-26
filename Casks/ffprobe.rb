cask "ffprobe" do
  version "7.1.1"
  sha256 "e695da37c08c8fbc218ebc161ee20d5606b50f3c7e8d696cbcf01bd40fe20d7e"

  url "https://www.osxexperts.net/ffprobe#{version.no_dots}arm.zip", verified: "osxexperts.net/"
  name "ffprobe"
  desc "Complete, cross-patform solution to convert audio and video"
  homepage "https://ffmpeg.org/"

  livecheck do
    url "https://www.osxexperts.net/"
    regex(/href=.*?ffprobe(\d+)arm\.zip/i)
  end

  depends_on macos: ">= :monterey"

  binary "ffprobe"

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
