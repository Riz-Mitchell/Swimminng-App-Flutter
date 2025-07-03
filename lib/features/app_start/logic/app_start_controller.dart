import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/core/router.dart';
import 'package:swimming_app_frontend/features/auth/logic/auth_provider.dart';

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
    final isLoggedIn = await ref.read(authProvider.notifier).checkIfLoggedIn();

    state = SplashStatus.showFirstText;
    await Future.delayed(const Duration(seconds: 3)); // Wait for anim to finish

    state = SplashStatus.showSecondText;
    await Future.delayed(const Duration(seconds: 3)); // Wait for anim to finish

    state = SplashStatus.expandCircle;
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Wait for circle to expand

    // Step 4: Navigate based on auth
    if (isLoggedIn) {
      ref.read(routerProvider).go('/home');
    } else {
      ref.read(routerProvider).go('/ca-initial');
    }

    state = SplashStatus.done;
  }
}

final splashControllerProvider =
    StateNotifierProvider<SplashController, SplashStatus>((ref) {
      return SplashController(ref);
    });
