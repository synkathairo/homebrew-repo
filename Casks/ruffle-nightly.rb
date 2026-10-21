cask "ruffle-nightly" do
  version "2026_10_21"
  sha256 "82b2e37025cb665a06697f8268e24452d01f298ca5fab05dd6981a0f981e8b3e"

  url "https://github.com/ruffle-rs/ruffle/releases/download/nightly-#{version.tr("_", "-")}/ruffle-nightly-#{version}-macos-universal.tar.gz"
  name "ruffle-nightly"
  desc "Open source Flash Player emulator"
  homepage "https://ruffle.rs/"

  livecheck do
    url "https://github.com/ruffle-rs/ruffle.git"
    regex(/^nightly-(\d{4}-\d{2}-\d{2})$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("-", "_") }
          .max
    end
  end

  depends_on :macos

  app "Ruffle.app"

  zap trash: [
    "~/Library/Application Support/ruffle",
    "~/Library/Caches/ruffle",
  ]
end
