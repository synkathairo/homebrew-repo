class OpenconnectGui < Formula
  desc "Graphical OpenConnect client"
  homepage "https://openconnect.github.io/openconnect-gui/"
  license "LGPL-2.1-or-later"

  head "https://gitlab.com/openconnect/openconnect-gui.git",
       branch: "develop"

  depends_on "cmake" => :build

  depends_on "llvm"
  depends_on "fmt"
  depends_on "spdlog"
  depends_on "openconnect"
  depends_on "qt"
  depends_on "qtscxml"

  livecheck do
    url "https://gitlab.com/openconnect/openconnect-gui/-/tags"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  def install
    system "cmake",
           "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.15"

    system "cmake", "--build", "build"

    prefix.install "build/bin/OpenConnect-GUI.app"
  end

  def post_install
    appdir.install_symlink prefix/"OpenConnect-GUI.app"
  end

  test do
    assert_predicate prefix/"OpenConnect-GUI.app", :exist?
  end
end
