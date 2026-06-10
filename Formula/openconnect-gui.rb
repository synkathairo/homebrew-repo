class OpenconnectGui < Formula
  desc "Graphical OpenConnect client"
  homepage "https://openconnect.github.io/openconnect-gui/"
  url "https://gitlab.com/openconnect/openconnect-gui/-/archive/v1.6.2/openconnect-gui-v1.6.2.tar.gz"
  sha256 "a83b913dcbf65d17e32282debe4f3b09a71aa3ced3d990af67a4b95ecae7649b"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://gitlab.com/openconnect/openconnect-gui/-/tags"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build

  depends_on "fmt"
  depends_on "openconnect"
  depends_on "qt"
  depends_on "qtscxml"
  depends_on "spdlog"

  def install
    ENV.deparallelize

    system "cmake",
           "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_OSX_DEPLOYMENT_TARGET=10.15"

    system "cmake", "--build", "build"

    prefix.install "build/bin/OpenConnect-GUI.app"
  end

  def post_install
    app = Pathname("/Applications/OpenConnect-GUI.app")
    app.delete if app.symlink?
    app.make_symlink(opt_prefix/"OpenConnect-GUI.app")
  end

  test do
    assert_path_exists prefix/"OpenConnect-GUI.app"
  end
end
