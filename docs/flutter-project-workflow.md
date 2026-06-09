# Flutter Project Workflow

This document is the operating path for teams using this repository as a
Flutter application template. It connects the Make targets, generated files,
tests, CI, and release process into one workflow.

## 1. Create a Product Repository

Create a new repository from this template, then run:

```bash
make setup
dart run tool/init_project.dart
make generate
make check
```

The initializer replaces template identifiers such as the Dart package name,
Android application id, Apple bundle id, display name, and GitHub badge URLs.

Review these files before the first product commit:

- `pubspec.yaml`
- `.env.example`
- `android/app/build.gradle.kts`
- `ios/Runner.xcodeproj/project.pbxproj`
- `macos/Runner/Configs/AppInfo.xcconfig`
- `web/manifest.json`
- `.github/**`

When the product identity is stable, remove the initializer:

```bash
rm tool/init_project.dart
```

## 2. Prepare a Local Machine

Install Flutter from the version pinned in `.fvmrc`. If your team uses FVM,
run commands with FVM or override the Make variables:

```bash
make setup FLUTTER="fvm flutter" DART="fvm dart"
```

Install Git hooks when Lefthook is available:

```bash
make hooks-install
```

Run the baseline checks:

```bash
make check
```

## 3. Build a Feature Slice

Place product code under `lib/src/features/<feature>/`. Start with only the
folders the feature actually needs:

```text
lib/src/features/<feature>/
|-- application/
|-- data/
|-- domain/
`-- presentation/
```

Keep app-level composition in `lib/src/app/`, reusable UI and utilities in
`lib/src/shared/`, and user-facing strings in `lib/l10n/`.

For each slice:

- add fast unit or widget tests in `test/`
- add or update ARB strings in `lib/l10n/`
- add Patrol coverage only for native or end-to-end behavior
- run `make generate` when generated files change
- run `make check` before opening a PR

## 4. Configure Environments

Runtime configuration is passed through Dart defines. Use Make variables instead
of raw Flutter commands:

```bash
make run-staging API_BASE_URL=https://staging-api.example.com
make build-release-web APP_ENV=production API_BASE_URL=https://api.example.com
```

Do not put secrets in Dart defines. Values passed through `--dart-define` are
compiled into the app bundle and can be inspected by end users.

## 5. Test the Right Layer

Use the fastest reliable test for the behavior under change:

- domain and parsing rules: unit tests
- widgets, empty states, and error states: widget tests
- app startup and smoke coverage: app/widget smoke tests
- permissions, platform views, deep links, files, camera, and auth handoffs:
  Patrol tests

Useful commands:

```bash
make test
make coverage-check COVERAGE_MIN=80
make patrol-test-android PATROL_DEVICE=emulator-5554
```

## 6. Open a Pull Request

Before opening a PR:

```bash
make setup
make generate
make check
```

For risky user journeys, also run the relevant Patrol target. Keep PR titles in
Conventional Commit style so semantic PR checks and release notes stay useful.

## 7. Release

Prepare releases from a green protected branch:

```bash
make release-check APP_ENV=production
make tag VERSION=1.2.3
```

Store signing material, provisioning profiles, API tokens, and deployment
credentials outside the repository. Platform-specific signing and store upload
automation should be added by the product team because distribution channels
and credentials vary by app.
