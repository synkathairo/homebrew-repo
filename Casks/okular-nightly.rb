cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  sha256 arm:   "5a923d3e142949569f5d761b0cea3695850be3ba2cfb4d5e4b8b40ad905c36e6",
         intel: "3d7130cb57b7aefa9b4ddc416d2aa2af714fff4c5d4ddb8f8d25b50011cdbe69"

  on_arm do
    version "8320"
  end
  on_intel do
    version "8320"
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
