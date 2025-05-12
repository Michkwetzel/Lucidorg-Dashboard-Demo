import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/job_creation_screen.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/temp.dart';
import 'package:platform_front/lucid_HR/components/home/home_body_org.dart';
import 'package:platform_front/lucid_HR/components/results/results_body_org.dart';
import 'package:platform_front/lucid_ORG/archive/impact/org_impact/org_impact/org_impact_main_view.dart';
import 'package:platform_front/lucid_ORG/archive/impact/org_impact/org_impact_sb/org_impact_SB.dart';
import 'package:platform_front/lucid_ORG/components/company_info/companyInfoBody.dart';
import 'package:platform_front/lucid_ORG/components/assessment/create/createAssessmentBody.dart';
import 'package:platform_front/lucid_ORG/components/assessment/current/current_assessment_body.dart';
import 'package:platform_front/lucid_ORG/components/export/export_main_layout.dart';
import 'package:platform_front/lucid_ORG/components/global_org/errorScreen/errorScreen.dart';
import 'package:platform_front/lucid_ORG/components/home/homeScreenBody.dart';
import 'package:platform_front/lucid_ORG/components/howTo/how_to_body.dart';
import 'package:platform_front/lucid_ORG/components/focus/focus_body.dart';
import 'package:platform_front/lucid_ORG/components/results/resultsBody.dart';
import 'package:platform_front/global_components/main_sections/authscreen.dart';
import 'package:platform_front/global_components/main_sections/dashboardScaffold.dart';

GoRouter setupRouter() {
  return GoRouter(
    initialLocation: '/auth',
    routerNeglect: true,
    routes: [
      // Lucid_HR routes
      ShellRoute(
          builder: (context, state, child) {
            return Dashboardscaffold(body: child);
          },
          routes: [
            GoRoute(
              path: '/newJobSearch_hr',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: JobCreationScreen(),
                );
              },
            ),
            GoRoute(
              path: '/home_hr',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: HomeBodyOrg(),
                );
              },
            ),
            GoRoute(
              path: '/results_hr',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: ResultsBodyHR(),
                );
              },
            )
          ]),

      // Lucid_ORG routes
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
            path: '/home_org',
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
            path: '/results_org',
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
                child: FocusBody(),
              );
            },
          ),
          GoRoute(
            path: '/theFix',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Impact', style: kH1TextStyle),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        spacing: 32,
                        children: [
                          Container(margin: EdgeInsets.only(left: 5, bottom: 5), width: 350, decoration: kboxShadowNormal, child: OrgImpactSB()),
                          OrgImpactMainView(),
                        ],
                      ),
                    ],
                  ),
                ),
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
