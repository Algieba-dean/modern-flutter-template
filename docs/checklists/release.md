# Release Checklist

## Before Release Branch

- [ ] Confirm all required issues are closed or moved.
- [ ] Confirm `main` is green in CI.
- [ ] Run `make release-check APP_ENV=production`.
- [ ] Run Android Patrol smoke tests on a real release candidate device.
- [ ] Run manual smoke tests on Android, iOS, and at least one desktop platform.
- [ ] Review dependency changes since the previous release.
- [ ] Review privacy, permissions, and store metadata changes.

## Versioning

- [ ] Update `version` in `pubspec.yaml`.
- [ ] Confirm Android version code strategy.
- [ ] Confirm iOS/macOS build number strategy.
- [ ] Tag the release with `make tag VERSION=X.Y.Z`.

## Platform Builds

- [ ] Android release build signed with production keystore.
- [ ] iOS archive signed with production profile.
- [ ] macOS build signed and notarized if distributed outside the App Store.
- [ ] Windows installer or archive produced.
- [ ] Linux package or archive produced.

## After Release

- [ ] Publish release notes.
- [ ] Monitor crash reporting and analytics.
- [ ] Triage post-release issues with `priority/high` or `priority/critical`.
