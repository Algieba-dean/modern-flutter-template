# Localization

The template uses Flutter's built-in `gen-l10n` tooling.

Source ARB files live in `lib/l10n/`. Generated Dart files are written to
`lib/src/localization/generated/` so the project is immediately readable after a
fresh clone and CI can verify generated output.

Generate localization sources with:

```bash
make gen-l10n
```

Add new user-facing strings to `lib/l10n/app_en.arb` first, then generate and
use `AppLocalizations.of(context)` from widgets. Add additional locales with
matching ARB files such as `app_zh.arb` or `app_es.arb`.

Do not hard-code product UI strings in widgets unless the text is intentionally
non-localizable, such as debug-only diagnostics or internal test labels.
