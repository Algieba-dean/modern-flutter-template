import 'dart:async';

import 'package:enterprise_flutter_template/src/app/app.dart';
import 'package:enterprise_flutter_template/src/app/app_config.dart';
import 'package:flutter/widgets.dart';

void bootstrap(AppConfig config) {
  runZonedGuarded<void>(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails details) {
        Zone.current.handleUncaughtError(
          details.exception,
          details.stack ?? StackTrace.current,
        );
      };

      runApp(App(config: config));
    },
    (Object error, StackTrace stackTrace) {
      debugPrint('Unhandled app error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
