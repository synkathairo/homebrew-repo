cask "treesheets" do
  version "2.22.6"
  sha256 "91b0859b26ec2651f99b967ac3f3e91577cd56cb1c17fb80dcff2ec5629c4742"

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
