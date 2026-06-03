# Homebrew Tap

Homebrew tap for `skill-cli`.

## Install

```sh
brew tap skill-cli/tap
brew install skill-cli/tap/skill-cli
```

Development builds can use the formula's `HEAD` source once the public source
repository exists:

```sh
brew install --HEAD skill-cli/tap/skill-cli
```

## Local Tap Testing

Tap this checkout when testing formula syntax, audit behavior, or tap layout
before publishing the tap repository:

```sh
brew tap skill-cli/tap /path/to/homebrew-tap
brew audit --strict skill-cli/tap/skill-cli
```

This validates the tap locally. It does not make the formula build from a local
source checkout; the formula source remains the public `skill-cli/cli`
repository.

For local source development, build from the source repository instead:

```sh
swift run skill --help
swift build -c release --product skill
```

## Formula

- Formula: `Formula/skill-cli.rb`
- Source repository: `skill-cli/cli`
- Installed executable: `skill`
- Swift driver shim: `swift-skill`

The formula builds the `skill` SwiftPM product from the source repository. Local
`file://` source formulae are intentionally kept out of this tap so the public
release path stays the same as the tested tap path.
