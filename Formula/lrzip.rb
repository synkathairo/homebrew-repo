class Lrzip < Formula
  desc "Compression program with a very high compression ratio"
  homepage "https://github.com/ckolivas/lrzip"
  url "https://github.com/ckolivas/lrzip/archive/refs/tags/v0.651.tar.gz"
  sha256 "f4c84de778a059123040681fd47c17565fcc4fec0ccc68fcf32d97fad16cd892"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    strategy :github_latest
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "lz4"
  depends_on "lzo"

  uses_from_macos "pod2man" => :build
  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  on_intel do
    depends_on "nasm" => :build
  end

  conflicts_with "lrzsz", because: "both install `lrz` binaries"

  def install
    # Attempting to build the ASM/x86 folder as a compilation unit fails (even on Intel). Removing this compilation
    # unit doesn't disable ASM usage though, since ASM is still included in the C build process.
    # See https://github.com/ckolivas/lrzip/issues/193
    inreplace "lzma/Makefile.am", "SUBDIRS = C ASM/x86", "SUBDIRS = C"

    # Set nasm format correctly on macOS. See https://github.com/ckolivas/lrzip/pull/211
    inreplace "configure.ac", "-f elf64", "-f macho64" if OS.mac?

    system "autoreconf", "--force", "--install", "--verbose"

    args = []
    args << "--disable-asm" unless Hardware::CPU.intel?

    system "./configure", *args, *std_configure_args
    system "make", "SHELL=bash"
    system "make", "install"
  end

  test do
    path = testpath/"data.txt"
    original_contents = "." * 1000
    path.write original_contents

    # compress: data.txt -> data.txt.lrz
    system bin/"lrzip", "-o", "#{path}.lrz", path
    path.unlink

    # decompress: data.txt.lrz -> data.txt
    system bin/"lrzip", "-d", "#{path}.lrz"
    assert_equal original_contents, path.read
  end
end
