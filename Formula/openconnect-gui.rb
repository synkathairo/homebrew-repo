class OpenconnectGui < Formula
  desc "Graphical OpenConnect VPN client"
  homepage "https://openconnect.github.io/openconnect-gui/"
  url "https://gitlab.com/openconnect/openconnect-gui/-/archive/v1.6.2/openconnect-gui-v1.6.2.tar.gz"
  sha256 "a83b913dcbf65d17e32282debe4f3b09a71aa3ced3d990af67a4b95ecae7649b"
  license "LGPL-2.1-or-later"

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
  depends_on "qt"
  depends_on "qtscxml"
  depends_on "spdlog"

  def install
    ENV.deparallelize

    # Upstream installs the bundle as OpenConnect-GUI.app because of OUTPUT_NAME,
    # but some install/fixup rules still reference ${PROJECT_NAME}.app
    # (openconnect-gui.app). That works on case-insensitive filesystems, but make
    # it consistent before using the upstream install target.
    inreplace "src/CMakeLists.txt", "${PROJECT_NAME}.app", "${PRODUCT_NAME_SHORT}.app"

    system "cmake",
           "-S", ".",
           "-B", "build",
           *std_cmake_args,
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.15"

    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_path_exists prefix/"OpenConnect-GUI.app"
  end
end
