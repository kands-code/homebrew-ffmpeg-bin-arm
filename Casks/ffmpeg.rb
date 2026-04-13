cask "ffmpeg" do
  version "8.1"
  sha256 "9a08d61f9328e8164ba560ee7a79958e357307fcfeea6fe626b7d66cdc287028"

  url "https://www.osxexperts.net/ffmpeg#{version.no_dots}arm.zip", verified: "osxexperts.net/"
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
