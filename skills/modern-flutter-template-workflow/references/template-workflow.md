# Template Workflow Reference

## Lifecycle

1. Initialize the template with `dart run tool/init_project.dart`.
2. Run `make generate` to sync generated localization sources.
3. Run `make check` before the first commit and before PRs.
4. Use `make coverage-check COVERAGE_MIN=80` for CI-equivalent coverage.
5. Use `make release-check APP_ENV=production` before release tags.

## Make Target Map

- Setup: `make setup`, `make get`, `make pub-get`
- Dependencies: `make outdated`, `make upgrade`, `make pub-upgrade-major`
- Formatting: `make format`, `make format-check`, `make fmt`
- Fixes: `make fix`, `make fix-apply`
- Generation: `make generate`, `make gen-l10n`
- Analysis: `make analyze`, `make lint`
- Tests: `make test`, `make test-verbose`, `make test-coverage`,
  `make coverage-check`
- Hooks: `make hooks-install`, `make hooks-run`
- Run: `make run`, `make run-dev`, `make run-staging`,
  `make run-production`, `make run-web`, `make run-macos`
- Debug builds: `make build-android-debug`, `make build-apk`,
  `make build-ios-simulator`, `make build-web`, `make build-macos-debug`,
  `make build-windows-debug`, `make build-linux-debug`
- Release builds: `make build-release-android-apk`,
  `make build-release-android-aab`, `make build-release-ios`,
  `make build-release-web`, `make build-release-macos`,
  `make build-release-windows`, `make build-release-linux`
- Release management: `make release-check`, `make tag VERSION=X.Y.Z`

## Repository Boundaries

Product Dart code belongs in `lib/src/features`. Shared UI and utilities belong
in `lib/src/shared`. App bootstrap and top-level composition belong in
`lib/src/app`. User-facing text belongs in `lib/l10n` and generated localization
sources belong in `lib/src/localization/generated`.

Platform code stays in the relevant host directory. Any platform channel should
have a Dart-facing interface in `lib/src/shared` or the owning feature.

## Configuration

Use Dart defines through Make variables:

```bash
make run-staging API_BASE_URL=https://staging-api.example.com
make build-release-web APP_ENV=production API_BASE_URL=https://api.example.com
```

Do not use Dart defines for secrets. They are compiled into app bundles.

## Automation

The repository expects GitHub Actions for CI, Patrol, labels, PR labels,
semantic PR title checks, release drafting, stale management, dependency
updates, dependency review, and CodeQL. Keep local workflow changes reflected in
README and docs.
