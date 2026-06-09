# Enterprise Flutter Template

[![CI](https://github.com/your-org/enterprise-flutter-template/actions/workflows/ci.yml/badge.svg)](https://github.com/your-org/enterprise-flutter-template/actions/workflows/ci.yml)
[![Patrol](https://github.com/your-org/enterprise-flutter-template/actions/workflows/patrol.yml/badge.svg)](https://github.com/your-org/enterprise-flutter-template/actions/workflows/patrol.yml)
![Flutter](https://img.shields.io/badge/flutter-stable-blue)
![Patrol](https://img.shields.io/badge/e2e-Patrol-6b46c1)
![License](https://img.shields.io/badge/license-MIT-green)

An enterprise-grade GitHub repository template for Flutter applications.

The template starts with Android, iOS, Web, macOS, Windows, and Linux support,
strict Dart analysis rules, GitHub repository automation, and Patrol as the
standard integration testing framework.

## Template Setup

1. Click **Use this template** on GitHub.
2. Clone the new repository.
3. Run the initializer:

```bash
dart run tool/init_project.dart
```

4. Review the generated identifiers in:

- `pubspec.yaml`
- `android/app/build.gradle.kts`
- `ios/Runner.xcodeproj/project.pbxproj`
- `macos/Runner/Configs/AppInfo.xcconfig`
- `web/manifest.json`
- `.env.example`
- `.github/**`

5. Install dependencies and verify the baseline:

```bash
make setup
make check
```

6. Remove the initializer when the project identity is stable:

```bash
rm tool/init_project.dart
```

## Requirements

- Flutter stable, 3.32.0 or newer
- Dart 3.11.0 compatible SDK
- JDK 17 for Android builds
- Xcode on macOS for iOS and macOS builds
- Visual Studio Build Tools for Windows desktop builds
- Linux GTK build dependencies for Linux desktop builds

The repository includes `.fvmrc` to pin the template SDK baseline. If your team
uses FVM, run commands through `fvm flutter` or set `FLUTTER=fvm flutter` when
calling `make`.

## Common Commands

| Task | Command |
| --- | --- |
| Show all commands | `make help` |
| Install dependencies | `make setup` |
| Format code | `make format` |
| Verify formatting | `make format-check` |
| Analyze code | `make analyze` |
| Run widget/unit tests | `make test` |
| Run coverage | `make test-coverage` |
| Enforce coverage threshold | `make coverage-check COVERAGE_MIN=80` |
| Run fast PR checks | `make check` |
| Build Android Patrol app | `make patrol-build-android` |
| Run Android Patrol smoke test | `make patrol-test-android PATROL_DEVICE=emulator-5554` |
| Build Android debug APK | `make build-android-debug` |
| Build iOS simulator app | `make build-ios-simulator` |
| Build Web app | `make build-web` |
| Build macOS desktop app | `make build-macos-debug` |
| Build Windows desktop app | `make build-windows-debug` |
| Build Linux desktop app | `make build-linux-debug` |
| Build production Web app | `make build-release-web APP_ENV=production` |
| Build Android release AAB | `make build-release-android-aab APP_ENV=production BUILD_NAME=1.2.3 BUILD_NUMBER=42` |
| Run release preflight | `make release-check APP_ENV=production` |

`Makefile` variables are overridable, for example:

```bash
make check FLUTTER=/path/to/flutter DART=/path/to/dart
make build-release-android-aab APP_ENV=production BUILD_NAME=1.2.3 BUILD_NUMBER=42
```

## Local Git Hooks

The template includes a `.lefthook.yml` configuration for local quality gates.
Install Lefthook and enable the hooks in each clone:

```bash
lefthook install
```

The default hooks verify formatting, static analysis, tests, and Conventional
Commit style commit messages before changes leave a developer machine.

## Project Structure

```text
.
├── .github/                 # GitHub Actions, issue templates, labels
├── android/                 # Android host project
├── ios/                     # iOS host project
├── lib/
│   ├── main.dart            # Runtime entrypoint
│   └── src/
│       ├── app/             # App shell, config, bootstrap
│       ├── features/        # Feature-first product code
│       └── shared/          # Shared UI, theme, utilities
├── linux/                   # Linux desktop host project
├── macos/                   # macOS desktop host project
├── patrol_test/             # Patrol E2E and integration tests
├── test/                    # Unit and widget tests
├── tool/                    # Template/project maintenance tools
├── web/                     # Web host project
└── windows/                 # Windows desktop host project
```

## Platform Support

This template keeps all Flutter host platforms enabled by default:

- Mobile: Android, iOS
- Desktop: macOS, Windows, Linux
- Web: Flutter web

Patrol is the default device-level integration testing framework. The template
preconfigures Android, iOS, and macOS Patrol identifiers in `pubspec.yaml`.
Android also includes the Patrol JUnit runner and orchestrator Gradle setup.

## Repository Automation

- `ci.yml`: format, analyze, unit/widget test, and multi-platform build checks
- `patrol.yml`: Android emulator Patrol smoke test
- `security.yml`: dependency review and CodeQL native host analysis
- `semantic-pr.yml`: Conventional Commit style PR title validation
- `pr-labeler.yml`: path-based PR labeling
- `labels.yml`: repository label synchronization
- `release-drafter.yml`: draft release notes from merged PR labels
- `stale.yml`: stale issue and PR management
- `dependabot.yml`: grouped GitHub Actions, Pub, and Gradle updates

## Documentation

- [Architecture](docs/architecture.md)
- [Code Style](docs/code-style.md)
- [Configuration](docs/configuration.md)
- [Testing Strategy](docs/testing.md)
- [Workflow Guidelines](docs/workflow.md)
- [Release Checklist](docs/checklists/release.md)

## License

This template is distributed under the MIT License. Replace the copyright owner
after initializing a real project.
