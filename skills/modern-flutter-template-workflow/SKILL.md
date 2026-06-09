---
name: modern-flutter-template-workflow
description: "Use this skill when working in this repository or repositories created from it and the task involves the full modern Flutter template workflow: initializing a product from the template, aligning project identity, using Makefile commands, configuring environments, running checks, preparing PRs, releases, or repository automation."
---

# Modern Flutter Template Workflow

Use the repository workflow instead of raw Flutter commands unless a task truly
requires lower-level debugging. Prefer `make help` first, then the target that
matches the lifecycle step.

## Core Rules

- Treat `Makefile` as the command interface for setup, generation, checks,
  builds, tests, hooks, and release preflight.
- Use `.fvmrc` as the Flutter SDK baseline. If FVM is needed, pass
  `FLUTTER="fvm flutter"` and `DART="fvm dart"` to Make targets.
- Keep generated localization files in sync with `make generate`.
- Never commit local secrets, real `.env` files, signing material, Firebase
  service files, or customer data.
- Preserve template portability: prefer documented examples and overridable
  variables over machine-specific paths.
- Before committing project workflow changes, run at least `make check` when
  feasible. If sandbox permissions block FVM cache writes, rerun with approved
  escalation rather than changing the workflow.

## Workflow

For a new product repository created from this template:

```bash
make setup
dart run tool/init_project.dart
make generate
make check
```

Then review:

- `pubspec.yaml`
- `.env.example`
- platform identifiers under `android/`, `ios/`, `macos/`, and `web/`
- `.github/**`
- `README.md` badges and repository names

After identity is stable, remove `tool/init_project.dart`.

## Verification Ladder

Use the narrowest useful check while iterating, then broaden before commit:

```bash
make format-check
make generate
make analyze
make test
make coverage-check COVERAGE_MIN=80
make check
```

Use Patrol for native or end-to-end behavior:

```bash
make patrol-test-android PATROL_DEVICE=emulator-5554
```

## Release Flow

Before a release:

```bash
make release-check APP_ENV=production
make tag VERSION=1.2.3
```

Keep platform signing, notarization, store upload, and deployment credentials
project-specific.

## References

- Read `references/template-workflow.md` for the complete project lifecycle.
- Read repository docs when needed: `docs/flutter-project-workflow.md`,
  `docs/configuration.md`, `docs/localization.md`, `docs/testing.md`,
  `docs/workflow.md`, and `docs/checklists/release.md`.
