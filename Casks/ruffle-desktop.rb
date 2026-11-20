cask "ruffle-desktop" do
  version "0.8.0"
  sha256 "da1527c22e2869274be8af07b7fe04fb8fb2a13a810dfc311722f8b328039e0c"

  url "https://github.com/ruffle-rs/ruffle/releases/download/v#{version}/ruffle-#{version}-macos-universal.tar.gz"
  name "Ruffle desktop"
  desc "Open source Flash Player emulator"
  homepage "https://ruffle.rs/"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "ruffle-desktop@nightly"
  depends_on :macos

  app "Ruffle.app"

  zap trash: [
    "~/Library/Application Support/ruffle",
    "~/Library/Caches/ruffle",
  ]
end
