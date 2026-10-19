# Agent guide

Read [README.md](README.md) and [CONTRIBUTING.md](CONTRIBUTING.md) first. Follow
the shared [maintenance change flow](https://github.com/agents-tools/.github/blob/master/MAINTENANCE.md#change-flow).

- Keep formula validation and source builds in the task's worktree or the
  release checklist's disposable environment. Use the README's local tap loop;
  a local tap still downloads the public upstream source.
- Run `brew style` and `brew audit --strict` for every `Formula/*.rb`, then
  `git diff --check origin/master`. Formula changes also require source
  installation and `brew test` as described in the README.
- Run `actionlint`, or parse every workflow as YAML, for workflow changes.
- Preserve the exact required contexts `policy / policy` and `homebrew`.
  Keep source policy separate from Homebrew validation so title-only edits
  rerun policy without replacing a validation result.
- Pin shared workflows to the reviewed full commit and direct actions to full
  commits with version comments. Follow the shared
  [workflow integration guide](https://github.com/agents-tools/.github/blob/master/Documentation/Reference/WorkflowIntegration.md)
  when changing pins or check names.
- The tap distributes upstream releases and has no release tags of its own.
  Formula updates follow the
  [skill release checklist](https://github.com/skill-cli/cli/blob/master/Documentation/Reference/Release.md).
