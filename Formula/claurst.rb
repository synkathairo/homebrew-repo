class Claurst < Formula
  desc "Agentic Coding for Builders who Ship"
  homepage "https://github.com/Kuberwastaken/claurst"
  url "https://github.com/Kuberwastaken/claurst/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "093daf446d64f96f1a0ccd3e58938744e614511d3fe642400dd8e01bf2797cea"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    cd "src-rust" do
      system "cargo", "install", *std_cargo_args(path: ".")
    end
  end

  test do
    assert_match "claurst", shell_output("#{bin}/claurst --help")
  end
end
