<p align="center">
  <a href="https://github.com/skill-cli/cli">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/skill-cli/.github/master/profile/assets/icon.png">
      <img src="https://raw.githubusercontent.com/skill-cli/.github/master/profile/assets/icon-dark.png" width="160" alt="skill logo">
    </picture>
  </a>
</p>

<h1 align="center">homebrew-tap</h1>

<p align="center">Install skill with Homebrew.</p>

<p align="center">
  <a href="https://github.com/skill-cli/homebrew-tap/actions/workflows/ci.yml"><img src="https://github.com/skill-cli/homebrew-tap/actions/workflows/ci.yml/badge.svg?branch=master" alt="CI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue" alt="License: MIT"></a>
</p>

<p align="center">
  <a href="#overview">Overview</a> ·
  <a href="#quick-look">Quick look</a> ·
  <a href="#install">Install</a> ·
  <a href="#formula-maintenance">Formula maintenance</a> ·
  <a href="#contributing">Contributing</a> ·
  <a href="#license">License</a>
</p>

## Overview

This tap distributes [skill](https://github.com/skill-cli/cli), a package
manager for agent skills. [Formula/skill-cli.rb](Formula/skill-cli.rb) builds
the upstream `skill` SwiftPM product and installs the `skill` executable plus
the `swift-skill` driver shim.

## Quick look

```sh
brew tap skill-cli/tap
brew install skill-cli/tap/skill-cli
skill --version
```

## Install

The Quick look installs the stable release selected by the formula's archive
URL and SHA-256. Homebrew, macOS 13 (Ventura) or later, and Xcode with a Swift
toolchain compatible with the selected source are required to build it.

For a development build from the upstream `master` branch, use the separate
HEAD channel:

```sh
brew install --HEAD skill-cli/tap/skill-cli
```

Both channels use the public [source repository](https://github.com/skill-cli/cli).
Tapping a local checkout changes which formula Homebrew reads, not which source
it builds. Local `file://` source formulae are kept out of this tap so the public
release path stays the same as the tested tap path. For source development,
run these commands in a checkout of the CLI repository:

```sh
swift run skill --help
swift build -c release --product skill
```

## Formula maintenance

Prepare updates after the upstream release is published, following the
[skill release checklist](https://github.com/skill-cli/cli/blob/master/Documentation/Reference/Release.md).
Set the stable archive URL to that release and compute SHA-256 from the exact
downloaded archive bytes. Keep HEAD pointed at the development branch. Record
the selected release, archive digest, formula changes and validation in the
pull request. This tap has no independent versions or release tags; the
[family versioning standard](https://github.com/agents-tools/.github/blob/master/VERSIONING.md)
owns release order.

From the task worktree on macOS, expose the current files through an unused
local tap. The symlink includes uncommitted formula edits and leaves the
installed `skill-cli/tap` checkout alone:

```sh
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_FROM_API=1
tap_directory="$(brew --repository)/Library/Taps/skill-cli/homebrew-local"
test ! -e "$tap_directory" && test ! -L "$tap_directory" || exit 1
mkdir -p "$(dirname "$tap_directory")"
ln -s "$PWD" "$tap_directory" || exit 1
for formula in Formula/*.rb; do
  name="skill-cli/local/$(basename "$formula" .rb)"
  brew style "$name" && brew audit --strict "$name" || exit 1
done
git diff --check origin/master
```

For a formula change, also follow the release checklist's disposable-environment
procedure to run `brew install --build-from-source` and `brew test`. Check both
`skill --version` and `swift-skill --version` against the selected release.
Remove the local tap symlink with `unlink "$tap_directory"` when finished.
For workflow edits, run `actionlint` (or parse every workflow as YAML).

CI runs on branch pushes and pull requests. The `homebrew` job on macOS checks
style and strict audit for every `Formula/*.rb`; a pull request changing a
formula also builds it from source and runs its tests. Homebrew CI can be run
manually. Source policy runs separately, including on pull request title edits.
The required contexts are `policy / policy` and `homebrew`, as declared in
[family maintenance](https://github.com/agents-tools/.github/blob/master/MAINTENANCE.md#activation-and-required-checks).

## Contributing

Read the shared [organization guide](https://github.com/agents-tools/.github/blob/master/CONTRIBUTING.md)
and [maintenance change flow](https://github.com/agents-tools/.github/blob/master/MAINTENANCE.md#change-flow).
[CONTRIBUTING.md](CONTRIBUTING.md) covers the tap's development loop.

## License

This tap is available under the [MIT License](LICENSE).
