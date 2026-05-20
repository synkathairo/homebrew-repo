cask "ruffle-nightly" do
  version "2026_05_20"
  sha256 "9954aaa9485bfb69fd4925ced991fc9c0c9255cf3af860a162c4fd807c9c870c"

  url "https://github.com/ruffle-rs/ruffle/releases/download/nightly-#{version.tr("_", "-")}/ruffle-nightly-#{version}-macos-universal.tar.gz",
      verified: "github.com/ruffle-rs/ruffle/"
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

  depends_on macos: :big_sur

  app "Ruffle.app"

  zap trash: [
    "~/Library/Application Support/ruffle",
    "~/Library/Caches/ruffle",
  ]
end
