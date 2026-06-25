class OpenconnectGui < Formula
  desc "Graphical OpenConnect VPN client"
  homepage "https://openconnect.github.io/openconnect-gui/"
  url "https://gitlab.com/openconnect/openconnect-gui/-/archive/v1.6.2/openconnect-gui-v1.6.2.tar.gz"
  sha256 "a83b913dcbf65d17e32282debe4f3b09a71aa3ced3d990af67a4b95ecae7649b"
  license "LGPL-2.1-or-later"
  head "https://gitlab.com/openconnect/openconnect-gui.git", branch: "main"

  livecheck do
    url "https://gitlab.com/openconnect/openconnect-gui/-/tags"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on xcode: :build
  depends_on "fmt"
  depends_on macos: :catalina
  depends_on "openconnect"
  depends_on "qtbase"
  depends_on "qtscxml"
  depends_on "spdlog"

  def install
    ENV.deparallelize

    # Upstream installs the bundle as OpenConnect-GUI.app because of OUTPUT_NAME,
    # but some install/fixup rules still reference ${PROJECT_NAME}.app
    # (openconnect-gui.app). That works on case-insensitive filesystems, but make
    # it consistent before using the upstream install target.
    inreplace "src/CMakeLists.txt", "${PROJECT_NAME}.app", "${PRODUCT_NAME_SHORT}.app"

    # Homebrew formulae should use Homebrew-managed shared libraries rather than
    # copying dependencies into the .app. Upstream's fixup_bundle currently also
    # misidentifies Qt framework headers as Mach-O files with Homebrew's Qt.
    inreplace "src/CMakeLists.txt",
              'fixup_bundle(\"${APPS}\" \"${additionalLib}\" \"${libSearchDirs}\")',
              'message(STATUS \"Skipping fixup_bundle for Homebrew\")'

    system "cmake",
           "-S", ".",
           "-B", "build",
           *std_cmake_args,
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.15"

    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      OpenConnect-GUI.app was installed to:
        #{opt_prefix}/OpenConnect-GUI.app

      To launch it, run:
        open #{opt_prefix}/OpenConnect-GUI.app

      To make it appear in /Applications, run:
        ln -s #{opt_prefix}/OpenConnect-GUI.app /Applications/OpenConnect-GUI.app
    EOS
  end

  test do
    assert_path_exists prefix/"OpenConnect-GUI.app"
  end
end
