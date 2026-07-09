cask "font-jigmo" do
  version "20250912"
  sha256 "2fb963ee7bba1d23ccfe81b228422f22da9dc574"

  url "https://kamichikoichi.github.io/jigmo/Jigmo-#{version}.zip"
  name "Jigmo（字雲）フォント"
  homepage "https://kamichikoichi.github.io/jigmo/"

  font "Jigmo.ttf"
  font "Jigmo2.tff"
  font "Jigmo3.ttf"

  # No zap stanza required
end
