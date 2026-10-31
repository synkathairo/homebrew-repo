cask "horizon-launcher" do
  version "0.2.30"
  sha256 "74c386c5b0d7d29cca01174cbaa180740bb0c598c4a0f586f3520c2559f838ec"

  url "https://github.com/horizon-rust/horizon/releases/download/launcher@#{version}/horizon-launcher-macos-arm64.dmg"
  name "Horizon launcher"
  desc "Minecraft: Java Edition 26.3 rewritten in Rust"
  homepage "https://playhorizon.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "Horizon.app"

  zap trash: [
    "~/Library/Application Support/horizon",
    "~/Library/Application Suppport/horizon-launcher",
    "~/Library/Preferences/dev.horizon.launcher.plist",
    "~/Library/Saved Application State/dev.horizon.launcher.savedState",
  ]
end
