import 'package:enterprise_flutter_template/src/app/app_config.dart';
import 'package:enterprise_flutter_template/src/features/home/presentation/home_page.dart';
import 'package:enterprise_flutter_template/src/localization/generated/app_localizations.dart';
import 'package:enterprise_flutter_template/src/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) => MaterialApp(
    onGenerateTitle: (BuildContext context) =>
        AppLocalizations.of(context).appTitle,
    debugShowCheckedModeBanner: false,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: HomePage(config: config),
  );
}
