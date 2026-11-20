cask "ruffle-desktop" do
  version "0.7.1"
  sha256 "7a86a09b0ca1d5756abcbb093108265019d77edad79e91c98689126c940bea4e"

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
