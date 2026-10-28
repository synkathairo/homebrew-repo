
class Camilladsp < Formula
  desc "Powerful and flexible audio processing tool, designed for applications like active crossovers, room correction, and advanced audio filtering"
  homepage "https://github.com/HEnquist/camilladsp"
  url "https://github.com/HEnquist/camilladsp/archive/refs/tags/v4.1.3.tar.gz"
  sha256 "7e2fdca1e9c73885426ac889d27682c76d49ea1ea52c5f5bfe5356d7fdfa52df"
  license "GPL-3.0-only OR MPL-2.0"
  head "https://github.com/HEnquist/camilladsp.git", branch: "master"

  depends_on "rust" => :build
  depends_on "pkgconf" => :build

  on_linux do
    depends_on "alsa-lib"
  end

  def fetch
    system "cargo", "fetch", "--locked", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install",
           "--locked",
           "--offline",
           "--root", prefix,
           "--path", ".",
           "--bin", "camilladsp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/camilladsp --version")
  end
end

