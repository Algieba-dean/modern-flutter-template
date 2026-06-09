# Contributing

This repository uses a pull request based workflow. Direct commits to `main`
should be disabled in GitHub branch protection settings.

## Local Setup

```bash
make setup
make check
```

Run Patrol tests on a device or emulator when the change touches a user flow,
native permission, platform channel, deep link, notification, authentication,
or app lifecycle behavior.

```bash
make patrol-test-android PATROL_DEVICE=emulator-5554
```

## Branch Naming

Use short branch names with a type prefix:

- `feat/add-login`
- `fix/android-crash`
- `docs/update-release-checklist`
- `test/patrol-auth-flow`
- `ci/cache-flutter`

## Pull Requests

Every PR should:

- use a Conventional Commit style title, such as `feat: add login screen`
- link the related issue when one exists
- include tests for changed behavior
- update docs when workflow, architecture, or public behavior changes
- include screenshots or recordings for UI changes on mobile and desktop when
  visual behavior is relevant

## Commit Message Types

- `feat`: user-visible feature
- `fix`: bug fix
- `docs`: documentation only
- `style`: formatting only
- `refactor`: code change without intended behavior change
- `perf`: performance improvement
- `test`: tests only
- `build`: build system or dependency change
- `ci`: GitHub Actions or automation
- `chore`: maintenance task
- `revert`: revert a previous change

## Review Expectations

Reviewers should focus on correctness, test coverage, platform impact,
maintainability, and release risk. Style-only preferences should be enforced by
`dart format`, `analysis_options.yaml`, and shared documentation rather than
ad hoc review comments.
