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
import 'package:swimming_app_frontend/features/logbook/presentation/screens/swim_viewer_logbook_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/done_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/phone_num_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/verify_login_screen.dart';
import 'package:swimming_app_frontend/features/profile/domain/enum/profile_editing_type_enum.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/change_linked_racing_account_profile_screen.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/change_pfp_profile_screen.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/edit_field_profile_screen.dart';
import 'package:swimming_app_frontend/features/profile/presentation/screens/settings_profile_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/date_of_birth_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/height_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/initial_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/name_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/phone_number_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/sex_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/verify_signup_screen.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',

    redirect: (context, state) {
      final authStateAsync = ref.watch(authControllerProvider);
      print('redirect called with authStateAsync: $authStateAsync');

      return authStateAsync.when(
        data: (status) {
          final isLoggedIn = status == LoginStatus.loggedIn;

          final loggedOutAllowedPaths = [
            '/login-or-signup',
            '/login-phonenumber', // allow this path
            '/login-verify',
            '/login-done',
            '/ca-initial',
            '/ca-add-name',
            '/ca-add-dob',
            '/ca-add-height',
            '/ca-add-sex',
            '/ca-add-phone-number',
            '/ca-verify-phone-number',
            '/',
          ];

          final currentPath = state.uri.path;

          if (!isLoggedIn && !loggedOutAllowedPaths.contains(currentPath)) {
            // if not logged in and not allowed, redirect
            return '/login-or-signup';
          }

          if (isLoggedIn && currentPath == '/login-done' ||
              currentPath == '/login-verify' ||
              currentPath == '/ca-verify-phone-number') {
            return null; // stay on the current page
          }

          if (isLoggedIn &&
              (currentPath == '/login-or-signup' || currentPath == '/')) {
            // if logged in, redirect from login or splash to home
            return '/home';
          }

          return null; // no redirect
        },
        loading: () => state.uri.path == '/' ? null : '/',
        error: (_, __) =>
            state.uri.path == '/login-or-signup' ? null : '/login-or-signup',
      );
    },
    debugLogDiagnostics: true,
    routes: [
      // Routes once authentication is complete and user is logged in
      // This is the main shell screen that will be used to navigate between different features of the app.
      // It will be used to wrap the main content of the app with a navigation bar
      // and other common UI elements.
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeShellScreen(),
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
        builder: (context, state) {
          print('Navigating to PhoneNumLoginScreen');
          return const PhoneNumLoginScreen();
        }, // Replace with DoneScreen
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
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsProfileScreen(),
      ),
      GoRoute(
        path: '/change-pfp',
        name: 'changePfp',
        builder: (context, state) => const ChangePFPProfileScreen(),
      ),
      GoRoute(
        path: '/change-linked-racing-account',
        name: 'changeLinkedRacingAccount',
        builder: (context, state) =>
            const ChangeLinkedRacingAccountProfileScreen(),
      ),
      GoRoute(
        path: '/edit-user-field',
        name: 'editUserField',
        builder: (context, state) {
          final editingType = state.extra as ProfileEditingTypeEnum;
          return EditFieldProfileScreen(editingType: editingType);
        },
      ),
    ],
  );

  ref.listen<AsyncValue<LoginStatus>>(authControllerProvider, (_, __) {
    router.refresh();
  });

  return router;
});
