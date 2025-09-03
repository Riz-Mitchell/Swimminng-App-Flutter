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

  LoginStatusEnum _getNextStatus() {
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    if (nextStatusIndex < LoginStatusEnum.values.length) {
      return LoginStatusEnum.values[nextStatusIndex];
    } else {
      return currentStatus;
    }
  }

  LoginStatusEnum _getPrevStatus() {
    final currentStatus = state.status;
    final prevStatusIndex = currentStatus.index - 1;

    if (prevStatusIndex >= 0) {
      return LoginStatusEnum.values[prevStatusIndex];
    } else {
      return currentStatus;
    }
  }

  Future<void> pushToLoginVerify() async {
    final nextStatus = _getNextStatus();

    final success = await ref
        .read(authControllerProvider.notifier)
        .requestOtp(state.loginForm.phoneNumber);

    if (!success) {
      state = state.copyWith(
        errorMessage:
            'Failed to request OTP. Please check the phone number and try again.',
      );
      return;
    }

    state = state.copyWith(
      status: nextStatus,
      errorMessage: null, // clear error on success
    );
    ref.read(routerProvider).push('/login-verify');
  }

  Future<void> pushToLoginDone() async {
    final nextStatus = _getNextStatus();

    final success = await ref
        .read(authControllerProvider.notifier)
        .login(state.loginForm);

    if (!success) {
      state = state.copyWith(errorMessage: 'Invalid OTP. Please try again.');
      return;
    }

    state = state.copyWith(status: nextStatus, errorMessage: null);
    ref.read(routerProvider).push('/login-done');
  }

  Future<void> popToLoginPhoneNumber() async {
    final prevStatus = _getPrevStatus();

    state = state.copyWith(status: prevStatus);
    ref.read(routerProvider).pop();
  }

  Future<void> exitToHome() async {
    ref.read(routerProvider).go('/home');
    ref.invalidateSelf();
  }

  Future<void> exitToLoginOrSignup() async {
    ref.read(routerProvider).go('/login-or-signup');
    ref.invalidateSelf();
  }
}

final loginProvider = NotifierProvider<LoginNotifier, LoginModel>(
  () => LoginNotifier(),
);
