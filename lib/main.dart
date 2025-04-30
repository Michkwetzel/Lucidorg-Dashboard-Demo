import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/core_config/setup_router.dart';
import 'package:platform_front/firebase_options.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}: '
        '${record.level.name}: '
        '${record.time}: '
        '${record.message}');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLogging();

  final router = setupRouter();
  NavigationService.initialize(router);

  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "LucidORG",
      scaffoldMessengerKey: SnackBarService.scaffoldKey,
      routerConfig: NavigationService.router,
    );
  }
}
