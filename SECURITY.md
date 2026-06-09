# Security Policy

## Supported Versions

Security fixes are accepted for the latest released version and the current
`main` branch unless a project-specific release policy says otherwise.

## Reporting a Vulnerability

Do not open a public issue for a suspected vulnerability.

Send a report to `security@example.com` with:

- affected version or commit
- affected platform, if platform-specific
- reproduction steps
- expected impact
- any logs, screenshots, or proof of concept details that are safe to share

The maintainers should acknowledge reports within 3 business days and provide a
triage update within 10 business days.

## Secrets

Never commit signing keys, API tokens, service account files, or production
configuration. Use GitHub Actions secrets and platform-specific secure storage.
