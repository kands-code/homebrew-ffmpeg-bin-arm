cask "ffmpeg" do
  version "7.1"
  sha256 "0878f3313311c2c1b2c818e7c955c0bd828c97b357fa86211b42a5c36d01e36f"

  url "https://www.osxexperts.net/ffmpeg#{version.major}#{version.minor}arm.zip", verified: "osxexperts.net/"
  name "ffmpeg"
  desc "Complete, cross-patform solution to convert audio and video"
  homepage "https://ffmpeg.org/"

  livecheck do
    url "https://www.osxexperts.net/"
    regex(/href=.*?ffmpeg(\d+)arm\.zip/i)
  end

  depends_on macos: ">= :monterey"

  binary "ffmpeg"

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
