import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swimming_app_frontend/features/app_start/ui/screens/splash_screen.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/create_acc_add_height.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/create_acc_add_name.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/create_acc_add_dob.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/create_acc_add_phone_number.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/create_acc_add_sex.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/create_acc_verify.dart';
import 'package:swimming_app_frontend/features/auth/ui/screens/initial_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) =>
            const AppStartScreen(), // Replace with SplashScreen if
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
            const CreateAccAddName(), // Replace with AddNameScreen if exists
      ),
      GoRoute(
        path: '/ca-add-dob',
        name: 'addDOBCA',
        builder: (context, state) =>
            const CreateAccAddDOB(), // Replace with AddDOBScreen if exists
      ),
      GoRoute(
        path: '/ca-add-height',
        name: 'addHeightCA',
        builder: (context, state) =>
            const CreateAccAddHeight(), // Replace with AddHeightScreen
      ),
      GoRoute(
        path: '/ca-add-sex',
        name: 'addSexCA',
        builder: (context, state) =>
            const CreateAccAddSex(), // Replace with AddSexScreen
      ),
      GoRoute(
        path: '/ca-add-phone-number',
        name: 'addPhoneNumberCA',
        builder: (context, state) =>
            const CreateAccAddPhoneNumber(), // Replace with AddPhoneNumberScreen
      ),
      GoRoute(
        path: '/ca-verify-phone-number',
        name: 'verifyPhoneNumberCA',
        builder: (context, state) =>
            const CreateAccVerify(), // Replace with VerifyPhoneNumberScreen
      ),
      //   GoRoute(
      //     path: '/ca-done',
      //     name: 'doneCA',
      //     builder: (context, state) =>
      //         const CreateAccDone(), // Replace with DoneScreen
      //   ),
    ],
  );
});
