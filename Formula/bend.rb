class Bend < Formula
  desc "Fast language that blocks AI mistakes via proof"
  homepage "https://bend-lang.com"
  url "https://bend-lang.com/dl/2.0.4.tar.gz"
  sha256 "dff7d7e7b42a4572c79d3084093521d198a93af4684d4a10fe8322c265481734"
  license "Apache-2.0"

  livecheck do
    url "https://bend-lang.com/dl/latest.json"
    strategy :json do |json|
      json["ver"]
    end
  end

  depends_on "bun"
  depends_on "llvm"
  depends_on :macos

  def install
    libexec.install "bend2", "guide"
    (bin/"bend").write <<~SH
      #!/bin/sh
      export CC="#{formula_opt_bin("llvm")}/clang"
      exec "#{formula_opt_bin("bun")}/bun" "#{libexec}/bend2/main.ts" "$@"
    SH
    (bin/"bend").chmod 0755
  end

  def caveats
    <<~EOS
      Bend sends anonymous usage data, unless `BEND_NO_TELEMETRY=1`.
      This formula disables automatic updates; updates are managed by Homebrew.

      Run `bend guide` to get started.
    EOS
  end

  test do
    assert_equal "bend #{version}\n", shell_output("#{bin}/bend --version")

    (testpath/"test.bend").write <<~BEND
      import Base

      def main() -> U32:
        (2 + 3 : U32)
    BEND
    assert_equal "5\n", shell_output("#{bin}/bend #{testpath}/test.bend")
  end
end
