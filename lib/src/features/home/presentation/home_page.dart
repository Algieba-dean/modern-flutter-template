import 'package:enterprise_flutter_template/src/app/app_config.dart';
import 'package:enterprise_flutter_template/src/app/app_constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppConstants.appName, style: textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text(
                    AppConstants.templateSummary,
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  _EnvironmentTile(config: config),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EnvironmentTile extends StatelessWidget {
  const _EnvironmentTile({required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: const Icon(Icons.verified_user_outlined),
      title: const Text('Runtime environment'),
      subtitle: Text(config.apiBaseUrl),
      trailing: Text(config.environment.label),
    ),
  );
}
