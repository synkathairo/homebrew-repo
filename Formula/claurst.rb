class Claurst < Formula
  desc "Agentic Coding for Builders who Ship"
  homepage "https://github.com/Kuberwastaken/claurst"
  url "https://github.com/Kuberwastaken/claurst/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "b75f053436f09007af59ab050cb96d7bc144c15b8281fd66f364e2b14c7114ea"
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
