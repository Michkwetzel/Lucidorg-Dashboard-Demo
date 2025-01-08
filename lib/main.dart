import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/dashboard/companyInfo/companyInfoBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/layouts/createAssessmentBody.dart';
import 'package:platform_front/components/dashboard/home/homelayout.dart';
import 'package:platform_front/components/errorScreen/errorScreen.dart';
import 'package:platform_front/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_front/screens/authscreen.dart';
import 'package:platform_front/screens/dashboardScaffold.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

//TODO: make sure the user can only fill out the survey once. Check if already filled out.

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.loggerName}: '
        '${record.level.name}: '
        '${record.time}: '
        '${record.message}');
  });
}

GoRouter setupRouter() {
  return GoRouter(
    initialLocation: '/auth',
    // Disable page transitions animations globally
    routerNeglect: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Dashboardscaffold(body: child);
        },
        routes: [
          GoRoute(
            path: '/createAssessment',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: CreateAssessmentBody(),
              );
            },
          ),
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomeLayout(),
              );
            },
          ),
          GoRoute(
            path: '/companyInfo',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: CompanyInfoBody(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/errorScreen',
        builder: (context, state) => const ErrorScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      )
    ],
  );
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
      scaffoldMessengerKey: SnackBarService.scaffoldKey,
      routerConfig: NavigationService.router,
    );
  }
}
