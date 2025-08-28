import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/screens/onboard_app_start_screen.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/screens/launch_app_start_screen.dart';
import 'package:swimming_app_frontend/features/home/presentation/screens/home_shell_screen.dart';
import 'package:swimming_app_frontend/features/link_external_swims/presentation/screens/link_external_swims_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/complete_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/distance_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/pool_type_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/questionaire_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/splits_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/stroke_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/screens/landing_logbook_screen.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/screens/swim_viewer_logbook_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/done_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/phone_num_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/verify_login_screen.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/landing_profile_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/date_of_birth_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/height_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/initial_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/name_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/phone_number_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/sex_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/verify_signup_screen.dart';
import 'package:swimming_app_frontend/features/squad/presentation/screens/landing_squad_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/main_shell_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Routes once authentication is complete and user is logged in
      // This is the main shell screen that will be used to navigate between different features of the app.
      // It will be used to wrap the main content of the app with a navigation bar
      // and other common UI elements.
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const HomeShellScreen(),
        ),
      ),
      GoRoute(
        path: '/swim-viewer',
        name: 'swimViewer',
        builder: (context, state) {
          return const SwimViewerLogbookScreen();
        },
      ),
      GoRoute(
        path: '/add-swim-landing',
        name: 'addSwimLanding',
        builder: (context, state) => const PoolTypeLogSwimsScreen(),
      ),
      GoRoute(
        path: '/add-swim-stroke',
        name: 'addSwimStroke',
        builder: (context, state) => const StrokeLogSwimsScreen(),
      ),
      GoRoute(
        path: '/add-swim-distance',
        name: 'addSwimDistance',
        builder: (context, state) => const DistanceLogSwimsScreen(),
      ),
      GoRoute(
        path: '/add-swim-splits',
        name: 'addSwimSplits',
        builder: (context, state) => const SplitsLogSwimsScreen(),
      ),
      GoRoute(
        path: '/add-swim-questionnaire',
        name: 'addSwimQuestionnaire',
        builder: (context, state) => const QuestionnaireLogSwimsScreen(),
      ),
      GoRoute(
        path: '/add-swim-complete',
        name: 'addSwimComplete',
        builder: (context, state) => const CompleteLogSwimsScreen(),
      ),

      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) =>
            const LaunchAppStartScreen(), // Replace with SplashScreen if
      ),
      GoRoute(
        path: '/ca-initial',
        name: 'initialCA',
        builder: (context, state) => const InitialScreen(),
      ),
      GoRoute(
        path: '/ca-add-name',
        name: 'addNameCA',
        builder: (context, state) =>
            const NameSignupScreen(), // Replace with AddNameScreen if exists
      ),
      GoRoute(
        path: '/ca-add-dob',
        name: 'addDOBCA',
        builder: (context, state) =>
            const DateOfBirthSignupScreen(), // Replace with AddDOBScreen if exists
      ),
      GoRoute(
        path: '/ca-add-height',
        name: 'addHeightCA',
        builder: (context, state) =>
            const HeightSignupScreen(), // Replace with AddHeightScreen
      ),
      GoRoute(
        path: '/ca-add-sex',
        name: 'addSexCA',
        builder: (context, state) =>
            const SexSignupScreen(), // Replace with AddSexScreen
      ),
      GoRoute(
        path: '/ca-add-phone-number',
        name: 'addPhoneNumberCA',
        builder: (context, state) =>
            const PhoneNumberSignupScreen(), // Replace with AddPhoneNumberScreen
      ),
      GoRoute(
        path: '/ca-verify-phone-number',
        name: 'verifyPhoneNumberCA',
        builder: (context, state) =>
            const VerifySignupScreen(), // Replace with VerifyPhoneNumberScreen
      ),
      GoRoute(
        path: '/login-or-signup',
        name: 'loginOrSignup',
        builder: (context, state) => const OnboardAppStartScreen(),
      ),
      GoRoute(
        path: '/login-phonenumber',
        name: 'login',
        builder: (context, state) =>
            const PhoneNumLoginScreen(), // Replace with DoneScreen
      ),
      GoRoute(
        path: '/login-verify',
        name: 'loginVerify',
        builder: (context, state) => const VerifyLoginScreen(),
      ),
      GoRoute(
        path: '/login-done',
        name: 'loginDone',
        builder: (context, state) => const DoneLoginScreen(),
      ),
      GoRoute(
        path: '/link-external-swims',
        name: 'linkExternalSwims',
        builder: (context, state) => const LinkExternalSwimsScreen(),
      ),
    ],
  );
});
