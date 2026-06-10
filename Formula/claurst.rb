class Claurst < Formula
  desc "Agentic Coding for Builders who Ship"
  homepage "https://github.com/Kuberwastaken/claurst"
  url "https://github.com/Kuberwastaken/claurst/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "3a1e8bdc935f43ab3c64c08e6e0ae6485412f41a4e9bed09910ed464c60aee18"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    cd "src-rust" do
      system "cargo", "build", "--release", "--locked", "--package", "claurst"
      bin.install "target/release/claurst"
    end
  end

  test do
    assert_match "claurst", shell_output("#{bin}/claurst --help")
  end
end
