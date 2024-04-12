cask "ffmpeg" do
  version "7.0"
  sha256 "563111a239fe70d2e5c84a5382204a7d0bf0a332385a92a44baff36d313e27f2"

  url "https://www.osxexperts.net/ffmpeg#{version.major}arm.zip", verified: "osxexperts.net/"
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
