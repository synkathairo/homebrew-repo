cask "ruffle-nightly" do
  version "2026_08_04"
  sha256 "85cf5044b56595b7dfe0ed18698548e1b79c73b9996ac02137ee0734f86a5bcb"

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
