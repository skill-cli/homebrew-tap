# Contributing

Follow the shared [organization guide](https://github.com/agents-tools/.github/blob/master/CONTRIBUTING.md)
and [maintenance change flow](https://github.com/agents-tools/.github/blob/master/MAINTENANCE.md#change-flow)
for preparing, signing, reviewing and merging changes.

Use the [README's formula maintenance loop](README.md#formula-maintenance)
from a task worktree on macOS. Validate every formula with `brew style` and
`brew audit --strict`, and run `git diff --check origin/master`. Formula changes
also need a source installation and `brew test` in the disposable environment
described by the
[skill release checklist](https://github.com/skill-cli/cli/blob/master/Documentation/Reference/Release.md).
Workflow edits need `actionlint` or a YAML parse of every workflow.

Include the commands and results with the change. The required CI contexts
are `policy / policy` and `homebrew`; see
[family maintenance](https://github.com/agents-tools/.github/blob/master/MAINTENANCE.md#activation-and-required-checks)
for their declaration and activation procedure. Policy checks pull request
title edits separately from Homebrew validation. The latter runs style and
strict audit for all formulae, then source installation and tests for formulae
changed by a pull request.
