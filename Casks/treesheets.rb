cask "treesheets" do
  version "2.23.12"
  sha256 "a49a51a0fa9f2ea823611c00a57de0024446c393ce054f1addc682f7bfd98753"

  url "https://github.com/aardappel/treesheets/releases/download/v#{version}/TreeSheets-#{version}-macOS.dmg"
  name "TreeSheets"
  desc "Hierarchical spreadsheet and outline application"
  homepage "https://strlen.com/treesheets/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on :macos

  app "TreeSheets.app"

  uninstall quit: "dot3labs.TreeSheets"

  zap trash: [
    "~/Library/Preferences/com.strlen.TreeSheets.plist",
    "~/Library/Preferences/dot3labs.TreeSheets.plist",
    "~/Library/Preferences/TreeSheets Preferences",
    "~/Library/Saved Application State/dot3labs.TreeSheets.savedState",
  ]
end
