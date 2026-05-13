class Claurst < Formula
  desc "Agentic Coding for Builders who Ship"
  homepage "https://github.com/Kuberwastaken/claurst"
  url "https://github.com/Kuberwastaken/claurst/archive/refs/tags/v0.0.9.tar.gz"
  sha256 "7410f02541ec5b59cdbe9db929ea2c7b5769ad00fe773d6766e5e21b5307490b"
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
