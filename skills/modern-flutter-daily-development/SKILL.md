---
name: modern-flutter-daily-development
description: Use this skill when making day-to-day code, test, documentation, localization, configuration, or platform changes in this modern Flutter template repository or a project created from it. It guides feature-slice development, local checks, generated files, PR readiness, and commit hygiene using the template workflow.
---

# Modern Flutter Daily Development

Use this skill for ordinary development work in the template: adding features,
fixing bugs, changing UI, adding strings, updating tests, touching platform
code, or preparing a PR.

## Daily Loop

1. Inspect the current state:

```bash
git status --short
make help
```

2. Make the smallest coherent change in the existing structure.
3. If user-facing strings changed, update `lib/l10n/*.arb` and run:

```bash
make generate
```

4. Add or update the right tests.
5. Run checks:

```bash
make check
```

6. For coverage-sensitive or CI-equivalent validation:

```bash
make coverage-check COVERAGE_MIN=80
```

## Feature Work

Put product code under `lib/src/features/<feature>/`. Create only the folders
the feature needs:

```text
lib/src/features/<feature>/
|-- application/
|-- data/
|-- domain/
`-- presentation/
```

Use unit tests for domain and parsing logic, widget tests for UI states, and
Patrol only for native or end-to-end behavior.

## Localization

- Add user-facing text to `lib/l10n/app_en.arb`.
- Run `make generate`.
- Use `AppLocalizations.of(context)` from widgets.
- Do not hard-code product UI strings unless they are intentionally
  non-localizable debug/test labels.

## Configuration

Use Make variables for runtime configuration:

```bash
make run-dev
make run-staging API_BASE_URL=https://staging-api.example.com
make build-release-android-aab APP_ENV=production BUILD_NAME=1.2.3 BUILD_NUMBER=42
```

Keep real values in CI, deployment, or platform-specific secret stores. Keep
`.env.example` as documentation only.

## Platform Changes

When changing Android, iOS, macOS, Windows, Linux, or Web host code:

- keep identifiers consistent with `pubspec.yaml` and Patrol config
- update docs if setup or release behavior changes
- run the platform build target when feasible
- add Patrol coverage for native flows that cannot be covered by widget tests

## Commit Readiness

Before committing:

```bash
make format-check
make generate
make analyze
make test
```

If the change touches release behavior, native behavior, or repository
automation, broaden validation with the relevant build, Patrol, or release
target.

## References

- Read `references/daily-development.md` for decision rules and common task
  recipes.
- Use `docs/flutter-project-workflow.md` as the repository source of truth for
  the end-to-end lifecycle.
