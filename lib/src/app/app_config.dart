enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment parse(String value) =>
      switch (value.trim().toLowerCase()) {
        'prod' || 'production' => AppEnvironment.production,
        'stage' || 'staging' => AppEnvironment.staging,
        _ => AppEnvironment.development,
      };

  String get label => switch (this) {
    AppEnvironment.development => 'Development',
    AppEnvironment.staging => 'Staging',
    AppEnvironment.production => 'Production',
  };
}

class AppConfig {
  const AppConfig({required this.environment, required this.apiBaseUrl});

  factory AppConfig.fromEnvironment() {
    const String environmentName = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const String apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.com',
    );

    return AppConfig(
      environment: AppEnvironment.parse(environmentName),
      apiBaseUrl: apiBaseUrl,
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;
}
