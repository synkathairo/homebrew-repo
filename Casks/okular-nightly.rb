cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  sha256 arm:   "b422a89c0cd97346b94a23a56aece6ef6fc33582f335f0d5eef3358263256694",
         intel: "e388016ea50a029c7dec2d7ee7c3e27c87abbb488d920f512ed5f901b0c988c0"

  on_arm do
    version "8335"
  end
  on_intel do
    version "8335"
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
