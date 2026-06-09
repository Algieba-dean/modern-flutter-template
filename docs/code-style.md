# Code Style

The repository enforces formatting and static analysis through:

- `make format-check`
- `make analyze`
- `analysis_options.yaml`
- GitHub Actions

## Dart Guidelines

- Use package imports for files under `lib/`.
- Prefer immutable widgets and `const` constructors.
- Keep build methods small enough to scan.
- Avoid `dynamic`; model external data explicitly.
- Avoid `print`; use the project's logging abstraction once one is added.
- Do not suppress lints without a short explanation.
- Keep comments for non-obvious decisions, not line-by-line narration.

## File Organization

- `test/`: fast unit and widget tests.
- `patrol_test/`: Patrol device-level integration and E2E tests.
- `docs/adr/`: architecture decision records.
- `tool/`: repository maintenance scripts.

## UI Guidelines

- Build adaptive layouts for phone, tablet, and desktop widths.
- Keep reusable widgets focused and named by behavior or domain meaning.
- Avoid platform-specific branching in widget trees unless the behavior really
  differs by platform.
- Add widget tests for states, validation, empty/error cases, and accessibility
  semantics when relevant.

## Dependency Guidelines

- Add a dependency only when it removes meaningful complexity or covers a
  mature platform concern.
- Prefer packages with active maintenance, sound null safety, and broad platform
  support.
- Document major architectural dependencies in `docs/architecture.md` or an ADR.
