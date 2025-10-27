cask "ffprobe" do
  version "8.0"
  sha256 "b46eb342707ec0d31d3e8337bb56831e59c9e20918f414fd7a9d65a32fcb348f"

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
