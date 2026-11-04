cask "okular-nightly" do
  arch arm: "arm64", intel: "x86_64"

  version "8225"
  sha256 arm:   "eff1035c73556f1da69ebd9bfc56fdc5b15b1b3c3667dffbc5c54e7e2b0d42a3",
         intel: "eed2851b9749d0edfabdde4bf3d0b3aeba6518f189fd5c7f054d16e30a21bc10"

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
