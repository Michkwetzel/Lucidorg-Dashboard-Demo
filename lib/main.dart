import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/dashboard/companyInfo/companyInfoBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/create/createAssessmentBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/current/current_assessment_body.dart';
import 'package:platform_front/components/dashboard/export/export_main_layout.dart';
import 'package:platform_front/components/dashboard/home/homeScreenBody.dart';
import 'package:platform_front/components/dashboard/howTo/how_to_body.dart';
import 'package:platform_front/components/dashboard/impact/impact_body.dart';
import 'package:platform_front/components/dashboard/results/resultsBody.dart';
import 'package:platform_front/components/global/errorScreen/errorScreen.dart';
import 'package:platform_front/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_front/mainSections/authscreen.dart';
import 'package:platform_front/mainSections/dashboardScaffold.dart';
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

GoRouter setupRouter() {
  return GoRouter(
    initialLocation: '/auth',
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
              return NoTransitionPage(
                child: CreateAssessmentBody(),
              );
            },
          ),
          GoRoute(
            path: '/currentAssessment',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: CurrentAssessmentBody(),
              );
            },
          ),
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomeScreenBody(),
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
          GoRoute(
            path: '/results',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ResultsBody(),
              );
            },
          ),
          GoRoute(
            path: '/impact',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ImpactBody(),
              );
            },
          ),
          GoRoute(
            path: '/theFix',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Placeholder(),
              );
            },
          ),
          GoRoute(
            path: '/howTo',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: HowToBody(),
              );
            },
          ),
          GoRoute(
            path: '/export',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: ExportMainLayout(),
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
    redirect: (context, state) async {
      // If you are not authenticated. You cant access any screens. so take you back to log in
      final isAuthenticated = FirebaseAuth.instance.currentUser != null;
      if (!isAuthenticated) {
        return '/auth';
      }

      // if (state.extra == null) {
      //   // Log user out if he reloads page. Always include an extra state if navigating using navigator. thus if reload you can notice it
      //   await FirebaseAuth.instance.signOut();
      //   return '/auth';
      // }
      return null;
    },
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
