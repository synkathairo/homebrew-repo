class Claurst < Formula
  desc "Agentic Coding for Builders who Ship"
  homepage "https://github.com/Kuberwastaken/claurst"
  url "https://github.com/Kuberwastaken/claurst/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "897bcc04f8f9904d0662f36c489ec97e3c116b1c3fe9d1d8ab14d27d7a49aac3"
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
