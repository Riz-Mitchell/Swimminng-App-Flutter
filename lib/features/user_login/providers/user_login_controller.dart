import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/providers/router_provider.dart';
import 'package:swimming_app_frontend/providers/login_user_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

enum LoginStatus { addPhoneNumber, verifyPhoneNumber, done }

class UserLoginController extends StateNotifier<LoginStatus> {
  final Ref ref;

  UserLoginController(this.ref) : super(LoginStatus.addPhoneNumber);

  Future<void> next() async {
    final currOtpReq = ref.read(otpReqProvider);
    final currLoginReq = ref.read(loginReqProvider);

    switch (state) {
      case LoginStatus.addPhoneNumber:
        try {
          final userService = ref.read(userServiceProvider);

          await userService.requestOtpFromServer(currOtpReq);

          state = LoginStatus.verifyPhoneNumber;
          ref.read(routerProvider).go('/login-verify');
        } catch (e) {
          // stay on page
        }
        break;
      case LoginStatus.verifyPhoneNumber:
        try {
          state = LoginStatus.done;
          ref.read(routerProvider).go('/login-done');
        } catch (e) {
          // Stay on page
        }
        break;
      case LoginStatus.done:
        // For when home page is implemented
        // ref.read(routerProvider).go('/home');
        break;
    }
  }
}

final userLoginControllerProvider =
    StateNotifierProvider<UserLoginController, LoginStatus>(
      (ref) => UserLoginController(ref),
    );
