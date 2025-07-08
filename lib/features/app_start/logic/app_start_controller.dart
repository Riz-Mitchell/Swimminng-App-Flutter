import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/router.dart';
import 'package:swimming_app_frontend/features/auth/logic/auth_provider.dart';
import 'package:swimming_app_frontend/providers/login_user_provider.dart';
import 'package:swimming_app_frontend/providers/startup_provider.dart';

enum SplashStatus {
  initial,
  authCheck,
  showFirstText,
  showSecondText,
  expandCircle,
  done,
}

class SplashController extends StateNotifier<SplashStatus> {
  final Ref ref;
  SplashController(this.ref) : super(SplashStatus.initial);

  Future<void> start() async {
    state = SplashStatus.authCheck;
    final isLoggedIn = ref.read(loginStatusProvider);

    state = SplashStatus.showFirstText;
    await Future.delayed(const Duration(seconds: 3)); // Wait for anim to finish

    state = SplashStatus.showSecondText;
    await Future.delayed(const Duration(seconds: 3)); // Wait for anim to finish

    state = SplashStatus.expandCircle;
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Wait for circle to expand

    isLoggedIn.when(
      data: (isLoggedIn) {
        ref.read(routerProvider).go(isLoggedIn ? '/home' : '/login-or-signup');
      },
      loading: () {
        // optional loading handler
      },
      error: (_, __) {
        ref.read(routerProvider).go('/login-or-signup');
      },
    );

    state = SplashStatus.done;
  }
}

final splashControllerProvider =
    StateNotifierProvider<SplashController, SplashStatus>((ref) {
      return SplashController(ref);
    });
