import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/screens/onboard_app_start_screen.dart';
import 'package:swimming_app_frontend/features/app_start/presentation/screens/launch_app_start_screen.dart';
import 'package:swimming_app_frontend/features/home/presentation/screens/heart_rate_screen.dart';
import 'package:swimming_app_frontend/features/home/presentation/screens/home.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/done_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/phone_num_login_screen.dart';
import 'package:swimming_app_frontend/features/login/presentation/screens/verify_login_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/date_of_birth_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/initial_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/name_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/phone_number_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/sex_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/screens/verify_signup_screen.dart';
import 'package:swimming_app_frontend/features/signup/presentation/widgets/height_picker_signup_widget.dart';
import 'package:swimming_app_frontend/features/swims/presentation/screens/swims_landing_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
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
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/heart-rate',
        name: 'heartRate',
        builder: (context, state) => const HeartRateScreen(),
      ),
      GoRoute(
        path: '/swims-landing',
        name: 'swimsLanding',
        builder: (context, state) => const SwimsLandingScreen(),
      ),
    ],
  );
});
