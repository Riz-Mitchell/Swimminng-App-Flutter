import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

enum SplashStatus {
  initial,
  authCheck,
  showFirstText,
  showSecondText,
  expandCircle,
  done,
}

class SplashStatusNotifier extends Notifier<SplashStatus> {
  @override
  SplashStatus build() => SplashStatus.initial;

  Future<void> start() async {
    state = SplashStatus.authCheck;
    bool isLoggedIn;
    try {
      print('attempting to check if logged in');
      final auth = await ref.read(authControllerProvider.future);
      final checkLoggedIn = await ref
          .read(userServiceProvider)
          .checkLoginStatusAsync();

      isLoggedIn = auth == LoginStatus.loggedIn && checkLoggedIn;

      print('logged in set to: $isLoggedIn, in start');
    } catch (e) {
      print('error: ${e}');
      isLoggedIn = false;
    }

    state = SplashStatus.showFirstText;
    await Future.delayed(const Duration(seconds: 3)); // Wait for anim to finish

    state = SplashStatus.showSecondText;
    await Future.delayed(const Duration(seconds: 3)); // Wait for anim to finish

    state = SplashStatus.expandCircle;
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Wait for circle to expand

    state = SplashStatus.done;

    ref
        .read(routerProvider)
        .go(isLoggedIn ? '/logbook-landing' : '/login-or-signup');
  }
}

final splashStatusProvider =
    NotifierProvider<SplashStatusNotifier, SplashStatus>(
      () => SplashStatusNotifier(),
    );
