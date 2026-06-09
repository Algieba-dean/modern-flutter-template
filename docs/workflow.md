# Workflow Guidelines

## Branches

- `main`: protected release branch.
- `feat/<short-name>`: feature work.
- `fix/<short-name>`: bug fixes.
- `test/<short-name>`: test-only changes.
- `docs/<short-name>`: documentation changes.
- `ci/<short-name>`: automation changes.

## Pull Requests

PRs should be small enough to review in one sitting. Large work should be split
by platform, feature slice, or infrastructure layer.

Before opening a PR:

```bash
make setup
make check
```

When changing localized strings, regenerate localization sources:

```bash
make gen-l10n
```

For CI-equivalent coverage enforcement, run:

```bash
make coverage-check COVERAGE_MIN=80
```

If Lefthook is installed locally, enable the shared Git hooks:

```bash
lefthook install
```

Run Patrol when the change touches a real user journey or native behavior:

```bash
make patrol-test-android PATROL_DEVICE=emulator-5554
```

## Review Standard

Review should prioritize:

- correctness
- platform regressions
- test coverage
- security and privacy
- maintainability
- release risk

## Security Checks

The security workflow runs dependency review on pull requests and CodeQL
analysis for native Android host code. Treat failures as release blockers unless
the team has reviewed and documented a false positive.

Do not commit real `.env` files, signing keys, provisioning profiles, Firebase
service files, API tokens, or customer data. Keep examples in `.env.example` and
store real values in CI, deployment, or platform-specific secret stores.

Enable GitHub secret scanning and push protection on the repository after it is
created from this template. If your organization standardizes on another scanner
such as Gitleaks or TruffleHog, add it as a separate required workflow.

## Labels

Labels are managed through `.github/labels.yml`. Prefer changing that file and
running the label sync workflow instead of editing labels manually in GitHub.

## Releases

Release notes are drafted from PR titles and labels. Use Conventional Commit
style PR titles so the generated notes remain useful.

Before cutting a release, run the release preflight:

```bash
make release-check APP_ENV=production
```

Platform store signing, notarization, and upload steps should live in
project-specific release automation because credentials and distribution
channels differ by product.
