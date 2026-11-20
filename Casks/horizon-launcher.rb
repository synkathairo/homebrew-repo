cask "horizon-launcher" do
  version "0.2.88"
  sha256 "0982aba103940d167ad1b96e5b5a1be2b14cad678c728a3db5f0b5f7f0cb984b"

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
