class Claurst < Formula
  desc "Agentic Coding for Builders who Ship"
  homepage "https://github.com/Kuberwastaken/claurst"
  url "https://github.com/Kuberwastaken/claurst/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "69b95f2013a6a3d1803c9ba9371f292d9961d59d16b92af47e8aef45015d0bea"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    cd "src-rust" do
      system "cargo", "install", *std_cargo_args(path: ".", bin: "claurst")
    end
  end

  test do
    assert_match "claurst", shell_output("#{bin}/claurst --help")
  end
end
