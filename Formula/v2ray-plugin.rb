class V2rayPlugin < Formula
  desc "SIP003 plugin based on v2ray for shadowsocks"
  homepage "https://github.com/shadowsocks/v2ray-plugin"
  url "https://github.com/shadowsocks/v2ray-plugin/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "fe8ba55a10f691a0bcdbbce2ede3b2f89226c4be0e403e51f8de2a3ad1bb44b9"
  license "MIT"
  head "https://github.com/shadowsocks/v2ray-plugin.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.VERSION=v#{version}", "-o", bin/"v2ray-plugin"
  end

  test do
    server = fork do
      exec bin/"v2ray-plugin", "-localPort", "54000", "-remoteAddr", "github.com", "-remotePort", "80", "-server"
    end
    client = fork do
      exec bin/"v2ray-plugin", "-localPort", "54001", "-remotePort", "54000"
    end
    sleep 2
    begin
      system "curl", "localhost:54001"
    ensure
      Process.kill 9, server
      Process.wait server
      Process.kill 9, client
      Process.wait client
    end
  end
end
