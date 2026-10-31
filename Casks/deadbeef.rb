cask "deadbeef" do
  version "1.10.3"
  sha256 "97eceb507ead2cc67bb9da3604d0f5f95c55a1738dd7aac19624cab229a4c281"

  url "https://sourceforge.net/projects/deadbeef/files/Builds/#{version}/macOS/deadbeef-#{version}-macos-universal.zip"
  name "DeaDBeeF"
  desc "Modular audio player"
  homepage "https://deadbeef.sourceforge.io/"

  livecheck do
    url :url
    strategy :sourceforge
    regex(%r{url=.*?/Builds/(\d+(?:\.\d+)+)/macOS/deadbeef-\1-macos-universal\.zip}i)
  end

  depends_on :macos

  app "DeaDBeeF.app"

  zap trash: [
    "~/Library/Preferences/com.deadbeef.deadbeef.plist",
    "~/Library/Preferences/deadbeef",
    "~/Library/Saved Application State/com.deadbeef.deadbeef.savedState",
  ]
end
