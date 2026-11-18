cask "horizon-launcher" do
  version "0.2.78"
  sha256 "c2c495a4c7a050720042b532ad635c7aae1654741cfc9891f1bab9602fba26e5"

  url "https://github.com/horizon-rust/horizon/releases/download/launcher@#{version}/horizon-launcher-macos-arm64.dmg"
  name "Horizon launcher"
  desc "Minecraft: Java Edition 26.3 rewritten in Rust"
  homepage "https://playhorizon.dev/"

  livecheck do
    url "https://github.com/horizon-rust/horizon.git"
    regex(/^launcher@(\d+(?:\.\d+)+)$/)
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Horizon.app"

  zap trash: [
    "~/Library/Application Support/horizon",
    "~/Library/Application Suppport/horizon-launcher",
    "~/Library/Preferences/dev.horizon.launcher.plist",
    "~/Library/Saved Application State/dev.horizon.launcher.savedState",
  ]
end
