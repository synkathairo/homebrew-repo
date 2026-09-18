cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  version "7939"
  sha256 arm:   "8bbc4a56c8a66c214a8a5b78f005c9a85139bd54c706af8f7c84b0746142dcf7",
         intel: "9b21b591050f83aba8e49661b5ebe85dc2280dfd9c46bf664a8523fa2fb71bb9"

  url "https://cdn.kde.org/ci-builds/graphics/okular/master/macos-#{arch}/okular-master-#{version}-macos-clang-#{arch}.dmg"
  name "Okular Nightly"
  desc "KDE's Universal Document Viewer"
  homepage "https://okular.kde.org/"

  livecheck do
    url "https://cdn.kde.org/ci-builds/graphics/okular/master/macos-arm64/"
    regex(/okular-master-(\d+)-macos-clang-arm64\.dmg/i)
  end

  depends_on macos: :ventura

  app "okular.app"

  zap trash: [
    "~/Library/Application Support/okular",
    "~/Library/Preferences/okular.plist",
    "~/Library/Preferences/okularpartrc",
    "~/Library/Preferences/okularrc",
    "~/Library/Preferences/org.kde.okular.plist",
  ]

  caveats <<~EOS
    This installs an unsigned nightly build from KDE CI.
    You may need to manually allow it by running
    `xattr -rd com.apple.quarantine /Applications/okular.app`
  EOS
end
