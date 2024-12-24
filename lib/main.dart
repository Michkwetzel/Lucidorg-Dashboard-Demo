import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_front/screens/authscreen.dart';
import 'package:platform_front/screens/dashboardScaffold.dart';


void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}: '
        '${record.level.name}: '
        '${record.time}: '
        '${record.message}');
  });
}

final _router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const Dashboardscaffold(),
    )
    //ShellRoute(routes: routes, builder: (context, state, child) => child)
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLogging();
 
  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
