cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  version "8104"
  sha256 arm:   "ef6a9b5e9fcf731b7f0664ea746167a7cc30fb8a2e95618512020ba0d7debe3e",
         intel: "de560ceb1c60e9c47161ff891f9b6fc4f291973cc3d1e14e0bcabd67c0dd8f77"

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
