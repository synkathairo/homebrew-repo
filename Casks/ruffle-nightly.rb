cask "ruffle-nightly" do
  version "2026_11_17"
  sha256 "b45092e08f2f43587431b5fc74039db2cb347e74c8fe8431da54614cb8ee34c5"

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
