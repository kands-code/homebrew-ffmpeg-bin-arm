cask "ffprobe" do
  version "9"
  sha256 "0c94fbdd8917022f28115eca512196cf4648732bc9e5db9ec8896c7e519d02aa"

  url "https://www.osxexperts.net/ffprobe#{version.no_dots}arm.zip", verified: "osxexperts.net/"
  name "ffprobe"
  desc "Complete, cross-patform solution to convert audio and video"
  homepage "https://ffmpeg.org/"

  livecheck do
    url "https://www.osxexperts.net/"
    regex(/href=.*?ffprobe(\d+)arm\.zip/i)
  end

  depends_on macos: :monterey

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
