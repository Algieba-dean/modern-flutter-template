# Architecture

This template uses a feature-first structure with a small app shell.

## Principles

- Keep platform-specific code in the host platform directories.
- Keep product code under `lib/src/features`.
- Keep reusable UI, theme, and utilities under `lib/src/shared`.
- Keep app bootstrap, runtime configuration, and top-level composition under
  `lib/src/app`.
- Prefer explicit dependencies over global mutable state.
- Make platform behavior testable through small adapters.

## Runtime Configuration

The app reads environment values with Dart defines:

```bash
flutter run \
  --dart-define=APP_ENV=staging \
  --dart-define=API_BASE_URL=https://staging-api.example.com
```

`AppConfig.fromEnvironment()` is the single place that maps Dart defines into
typed runtime configuration.

## Feature Boundaries

Recommended feature structure:

```text
lib/src/features/<feature>/
├── application/     # Use cases, controllers, orchestration
├── data/            # DTOs, repositories, remote/local data sources
├── domain/          # Entities and domain rules
└── presentation/    # Pages, widgets, view models
```

Use only the folders a feature actually needs. Do not create empty layers for
small features.

## Platform Boundaries

Platform code belongs in:

- `android/` for Android host project code
- `ios/` for iOS host project code
- `macos/`, `windows/`, and `linux/` for desktop host projects
- `web/` for web host code

Any platform channel should have a Dart-facing interface in `lib/src/shared` or
inside the owning feature. Tests should cover the Dart-facing contract.
