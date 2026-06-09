# Daily Development Reference

## Task Recipes

### Add or Change UI

1. Update widgets under the owning feature.
2. Move user-facing strings to `lib/l10n/app_en.arb`.
3. Run `make generate`.
4. Update widget tests in `test/`.
5. Run `make check`.

### Add Domain Logic

1. Place pure rules under the feature's `domain/` or `application/` folder.
2. Keep dependencies explicit.
3. Add focused unit tests.
4. Run `make test` and `make analyze`.

### Add Configuration

1. Extend `AppConfig` or `.env.example` only when the value is non-secret.
2. Document it in `docs/configuration.md`.
3. Thread it through Make variables when useful.
4. Do not put secrets into `--dart-define`.

### Add Platform Behavior

1. Keep platform implementation in the host platform directory.
2. Expose a Dart-facing interface in the owning feature or `lib/src/shared`.
3. Add fake implementations or test doubles for fast tests.
4. Add Patrol coverage for OS dialogs, permissions, deep links, files, camera,
   gallery, auth handoffs, and platform views.

### Update Dependencies

1. Run `make outdated`.
2. Prefer constraint-compatible upgrades with `make upgrade`.
3. Use `make pub-upgrade-major` only when intentionally accepting major changes.
4. Run `make check` and relevant build targets.

## Validation Choices

- Small Dart-only change: `make format-check`, `make analyze`, `make test`
- Generated/localization change: add `make generate`
- Coverage-sensitive change: `make coverage-check COVERAGE_MIN=80`
- Native or app journey change: add relevant Patrol target
- Release automation change: add `make release-check APP_ENV=production` when
  feasible

## Commit Hygiene

Use Conventional Commit messages:

- `feat: add onboarding shell`
- `fix(auth): handle expired session`
- `test: cover empty dashboard state`
- `docs: update release checklist`
- `ci: adjust coverage upload`

Do not include ignored build outputs, `.dart_tool`, `build`, `coverage`,
Patrol bundles, local IDE state, signing files, or secrets.
