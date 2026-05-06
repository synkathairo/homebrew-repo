# Homebrew repository

some useful software for macOS: `okular-nightly`

includes some casks which will be disabled in the [main Cask repo](https://github.com/Homebrew/homebrew-cask) after 1 September 2026 (no Gatekeeper signature): `chromium`, `darktable`, `digikam`, `djview`, `gstreamer-runtime`, `jgrennison-openttd`, `sabaki`, `tikzit`

## Notes

Some software may be unsigned, and requires running, for example 

`xattr -rd com.apple.quarantine /Applications/okular.app`
