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

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Small delay to allow Flutter to render the loading screen
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        title: "LucidORG",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                const SizedBox(height: 24),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: "LucidORG",
      scaffoldMessengerKey: SnackBarService.scaffoldKey,
      routerConfig: NavigationService.router,
    );
  }
}
