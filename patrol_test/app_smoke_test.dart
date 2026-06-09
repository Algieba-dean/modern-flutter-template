import 'package:enterprise_flutter_template/src/app/app.dart';
import 'package:enterprise_flutter_template/src/app/app_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('renders the application shell', ($) async {
    await $.pumpWidgetAndSettle(
      const App(
        config: AppConfig(
          environment: AppEnvironment.development,
          apiBaseUrl: 'https://api.example.com',
        ),
      ),
    );

    expect($('Enterprise Flutter Template'), findsWidgets);
    expect($('Development'), findsOneWidget);
  });
}
