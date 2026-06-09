# Testing Strategy

The template uses a layered testing strategy.

## Fast Tests

Use `test/` for unit and widget tests.

```bash
make test
```

Fast tests should cover:

- pure domain logic
- parsing and validation
- widget states
- navigation contracts where possible
- error and empty states

## Patrol Tests

Patrol is the standard integration testing framework for this template.

```bash
make patrol-test-android PATROL_DEVICE=emulator-5554
```

Use Patrol when testing:

- app lifecycle behavior
- native permission dialogs
- platform views
- notifications
- deep links
- authentication handoffs
- file pickers, camera, gallery, or OS-level flows

The template preconfigures Patrol for Android, iOS, and macOS in `pubspec.yaml`.
Android also includes `PatrolJUnitRunner` and an `androidTest` JUnit entrypoint.
Use `make patrol-build-ios`, `make patrol-test-ios`, `make patrol-build-macos`,
and `make patrol-test-macos` when those platform runners are available locally
or in CI.

## Platform Coverage

Baseline CI verifies:

- Android debug build
- iOS simulator build
- Web build
- macOS debug build
- Windows debug build
- Linux debug build
- Android Patrol smoke test

Add more Patrol flows when business-critical journeys are introduced. Keep them
small and deterministic; use unit and widget tests for exhaustive combinations.

## Test Data

- Keep test fixtures small and explicit.
- Do not use production credentials or real customer data.
- Prefer fake repositories and fake services for fast tests.
- Use isolated test environments for E2E tests.
