cask "horizon-launcher" do
  version "0.2.84"
  sha256 "722861729148f3435751d9a594b10cbf54f72bad9c29c952d871c0b0a0739c31"

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
