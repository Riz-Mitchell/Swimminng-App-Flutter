import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/login/domain/enum/login_status_enum.dart';
import 'package:swimming_app_frontend/features/login/domain/models/login_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class LoginNotifier extends Notifier<LoginModel> {
  @override
  LoginModel build() {
    return LoginModel(
      status: LoginStatusEnum.addPhoneNumber,
      loginForm: const LoginFormModel(phoneNumber: '', otp: ''),
    );
  }

  Future<void> updateLoginForm({String? phoneNumber, String? otp}) async {
    state = state.copyWith(
      loginForm: state.loginForm.copyWith(
        phoneNumber: phoneNumber ?? state.loginForm.phoneNumber,
        otp: otp ?? state.loginForm.otp,
      ),
    );
  }

  Future<void> navigateToNextStep() async {
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    if (nextStatusIndex < LoginStatusEnum.values.length) {
      final nextStatus = LoginStatusEnum.values[nextStatusIndex];

      switch (nextStatus) {
        case LoginStatusEnum.verifyPhoneNumber:
          await ref
              .read(authControllerProvider.notifier)
              .requestOtp(state.loginForm.phoneNumber);
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/login-verify');
          break;
        case LoginStatusEnum.done:
          await ref
              .read(authControllerProvider.notifier)
              .login(state.loginForm);
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/login-done');
          break;
        default:
          exit();
          break;
      }
    } else {
      exit();
    }
  }

  Future<void> navigateToPrevStep() async {
    final currentStatus = state.status;
    final prevStatusIndex = currentStatus.index - 1;

    if (prevStatusIndex < 0) {
      exit();
      return;
    }

    final prevStatus = LoginStatusEnum.values[prevStatusIndex];

    switch (prevStatus) {
      case LoginStatusEnum.addPhoneNumber:
        state = state.copyWith(status: prevStatus);
        ref.read(routerProvider).go('/login-or-signup');
        break;
      case LoginStatusEnum.verifyPhoneNumber:
        state = state.copyWith(status: prevStatus);
        ref.read(routerProvider).go('/login-phonenumber');
        break;
      case LoginStatusEnum.done:
        exit();
        break;
    }
  }

  Future<void> exit() async {
    switch (state.status) {
      case LoginStatusEnum.addPhoneNumber:
      case LoginStatusEnum.verifyPhoneNumber:
        ref.read(routerProvider).go('/login-or-signup');
        break;
      case LoginStatusEnum.done:
        ref.read(routerProvider).go('/home');
        break;
    }
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginModel>(
  () => LoginNotifier(),
);
