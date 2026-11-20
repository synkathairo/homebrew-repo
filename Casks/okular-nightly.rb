cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  sha256 arm:   "f8bdc1c55f69970b02dbb69cfb6a1fa24c82d1381a18c2edd0df61c5dbfe18ca",
         intel: "e08c32d87f72dd54d34a41b277d3d9c64b169cb44d568ceee74fac56dc16cb9b"

  on_arm do
    version "8320"
  end
  on_intel do
    version "8283"
  end

  url "https://cdn.kde.org/ci-builds/graphics/okular/master/macos-#{arch}/okular-master-#{version}-macos-clang-#{arch}.dmg"
  name "Okular Nightly"
  desc "KDE's Universal Document Viewer"
  homepage "https://okular.kde.org/"

  livecheck do
    url "https://cdn.kde.org/ci-builds/graphics/okular/master/macos-#{arch}/"
    regex(/okular-master-(\d+)-macos-clang-#{arch}\.dmg/i)
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
