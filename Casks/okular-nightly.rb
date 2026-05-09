cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  version "7389"
  sha256 arm:   "603304ca8c7b73ef9f45827d964b1f3fd487fa55211be7015faf12944b378097",
         intel: "5d2acf9fe1442b5cb347b52d9307fcebbba069f3bbe461ea74e7d92196f92283"

  url "https://cdn.kde.org/ci-builds/graphics/okular/master/macos-#{arch}/okular-master-#{version}-macos-clang-#{arch}.dmg"
  name "Okular Nightly"
  desc "KDE's Universal Document Viewer"
  homepage "https://okular.kde.org/"

  livecheck do
    url "https://cdn.kde.org/ci-builds/graphics/okular/master/macos-arm64/"
    regex(/okular-master-(\d+)-macos-clang-arm64\.dmg/i)
  end

  depends_on :macos

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
