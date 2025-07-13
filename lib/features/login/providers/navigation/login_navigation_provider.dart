import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/providers/router_provider.dart';

enum LoginStatus { addPhoneNumber, verifyPhoneNumber, done }

class LoginNavigationController extends Notifier<LoginStatus> {
  @override
  LoginStatus build() => LoginStatus.addPhoneNumber;

  Future<void> next() async {
    switch (state) {
      case LoginStatus.addPhoneNumber:
        await ref.read(authControllerProvider.notifier).requestOtp();
        ref.read(routerProvider).go('/login-verify');
        state = LoginStatus.verifyPhoneNumber;
        break;
      case LoginStatus.verifyPhoneNumber:
        await ref.read(authControllerProvider.notifier).login();
        ref.read(routerProvider).go('/login-done');
        state = LoginStatus.done;
        break;
      case LoginStatus.done:
        // For when home page is implemented
        // ref.read(routerProvider).go('/home');
        break;
    }
  }
}

final loginNavigationProvider =
    NotifierProvider<LoginNavigationController, LoginStatus>(
      () => LoginNavigationController(),
    );
