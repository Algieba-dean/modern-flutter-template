# Configuration

Runtime configuration is passed through Flutter compile-time environment values.
The app reads these values in `AppConfig.fromEnvironment()`:

- `APP_ENV`: `development`, `staging`, or `production`
- `API_BASE_URL`: base URL used by product API clients

Local runs can pass values through the Makefile:

```bash
make run APP_ENV=staging API_BASE_URL=https://staging-api.example.com
```

Builds use the same variables:

```bash
make build-release-android-aab APP_ENV=production API_BASE_URL=https://api.example.com
```

For CI and deployments, store real values in repository, environment, or
deployment variables. Use `.env.example` only as documentation for expected
keys; do not commit real credentials, signing files, tokens, or customer data.

Flutter `--dart-define` values are compiled into the app bundle. Do not use
them for secrets that must remain confidential from end users.
