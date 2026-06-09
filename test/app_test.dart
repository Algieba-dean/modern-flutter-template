import 'package:enterprise_flutter_template/src/app/app.dart';
import 'package:enterprise_flutter_template/src/app/app_config.dart';
import 'package:enterprise_flutter_template/src/app/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the template shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const App(
        config: AppConfig(
          environment: AppEnvironment.development,
          apiBaseUrl: 'https://api.example.com',
        ),
      ),
    );

    expect(find.text(AppConstants.appName), findsWidgets);
    expect(find.text('Development'), findsOneWidget);
  });
}
