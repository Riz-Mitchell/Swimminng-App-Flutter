import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/screens/onboard_app_start_screen.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/screens/launch_app_start_screen.dart';
import 'package:swimming_app_frontend/features/home/presentation/screens/heart_rate_screen.dart';
import 'package:swimming_app_frontend/features/home/presentation/screens/home.dart';
import 'package:swimming_app_frontend/features/log_swims/presentation/screens/pool_type_log_swims_screen.dart';
import 'package:swimming_app_frontend/features/logbook/presentation/screens/landing_logbook_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/done_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/phone_num_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/verify_login_screen.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/landing_profile_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/date_of_birth_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/initial_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/name_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/phone_number_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/sex_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/verify_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/height_picker_signup_widget.dart';
import 'package:swimming_app_frontend/features/squad/presentation/screens/landing_squad_screen.dart';
import 'package:swimming_app_frontend/features/swims/presentation/screens/swims_landing_screen.dart';
import 'package:swimming_app_frontend/shared/application/nav_direction_provider.dart';
import 'package:swimming_app_frontend/shared/presentation/screens/main_shell_screen.dart';
import 'package:swimming_app_frontend/shared/presentation/transitions/directional_page_transition.dart';

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
      ShellRoute(
        builder: (context, state, child) {
          final routeName = state.matchedLocation;

          if (routeName == '/profile-landing')
            return MainShellScreen(profileOverride: true, child: child);

          return MainShellScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const Home()),
          ),
          GoRoute(
            path: '/logbook-landing',
            name: 'logbook-landing',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const LandingLogbookScreen(),
              );
            },
          ),
          GoRoute(
            path: '/squad-landing',
            name: 'squad-landing',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LandingSquadScreen(),
            ),
          ),
          GoRoute(
            path: '/profile-landing',
            name: 'profile-landing',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LandingProfileScreen(),
            ),
          ),
          GoRoute(
            path: '/heart-rate',
            name: 'heartRate',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HeartRateScreen(),
            ),
          ),
          GoRoute(
            path: '/swims-landing',
            name: 'swimsLanding',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: const SwimsLandingScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/add-swim-landing',
        name: 'addSwimLanding',
        builder: (context, state) => const PoolTypeLogSwimsScreen(),
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
            const HeightPickerSignupWidget(), // Replace with AddHeightScreen
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
    ],
  );
});
