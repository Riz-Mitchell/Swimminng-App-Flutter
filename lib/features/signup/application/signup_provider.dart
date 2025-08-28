import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_sex_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_user_type_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/signup_status_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_model.dart';
import 'package:swimming_app_frontend/shared/application/providers/auth_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';

class SignupNotifier extends Notifier<SignupModel> {
  @override
  SignupModel build() {
    return SignupModel(
      status: SignupStatusEnum.initial,
      signupForm: SignupFormModel(
        name: '',
        phoneNumber: '',
        dateOfBirth: DateTime.now(),
        height: null,
        email: null,
        sex: SelectedSexEnum.unselected,
        userType: SelectedUserTypeEnum.unselected,
      ),
      loginForm: LoginFormModel(phoneNumber: '', otp: ''),
    );
  }

  Future<void> navigateToNextStep() async {
    final currentStatus = state.status;
    final nextStatusIndex = currentStatus.index + 1;

    if (nextStatusIndex < SignupStatusEnum.values.length) {
      final nextStatus = SignupStatusEnum.values[nextStatusIndex];

      switch (nextStatus) {
        case SignupStatusEnum.addName:
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-add-name');
          break;
        case SignupStatusEnum.addDOB:
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-add-dob');
          break;
        case SignupStatusEnum.addHeight:
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-add-height');
          break;
        case SignupStatusEnum.addSex:
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-add-sex');
          break;
        case SignupStatusEnum.addPhoneNumber:
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-add-phone-number');
          break;
        case SignupStatusEnum.verifyPhoneNumber:
          await ref
              .read(authControllerProvider.notifier)
              .signup(state.signupForm);
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-verify-phone-number');
          break;
        case SignupStatusEnum.done:
          await ref
              .read(authControllerProvider.notifier)
              .login(state.loginForm);
          state = state.copyWith(status: nextStatus);
          ref.read(routerProvider).go('/ca-done');
          break;
        default:
          exit();
          break;
      }
    }
  }

  Future<void> navigateToPrevStep() async {
    final currentStatus = state.status;
    final prevStatusIndex = currentStatus.index - 1;

    if (prevStatusIndex >= 0) {
      final prevStatus = SignupStatusEnum.values[prevStatusIndex];

      state = state.copyWith(status: prevStatus);
      switch (prevStatus) {
        case SignupStatusEnum.initial:
          ref.read(routerProvider).go('/ca-initial');
          break;
        case SignupStatusEnum.addName:
          ref.read(routerProvider).go('/ca-add-name');
          break;
        case SignupStatusEnum.addDOB:
          ref.read(routerProvider).go('/ca-add-dob');
          break;
        case SignupStatusEnum.addHeight:
          ref.read(routerProvider).go('/ca-add-height');
          break;
        case SignupStatusEnum.addSex:
          ref.read(routerProvider).go('/ca-add-sex');
          break;
        default:
          exit();
          break;
      }
    } else {
      exit();
    }
  }

  Future<void> updateSignupForm({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    double? height,
    String? email,
    SelectedSexEnum? sex,
    SelectedUserTypeEnum? userType,
  }) async {
    final currentForm = state.signupForm;

    final updatedForm = currentForm.copyWith(
      name: name ?? currentForm.name,
      phoneNumber: phoneNumber ?? currentForm.phoneNumber,
      dateOfBirth: dateOfBirth ?? currentForm.dateOfBirth,
      height: height ?? currentForm.height,
      email: email ?? currentForm.email,
      sex: sex ?? currentForm.sex,
      userType: userType ?? currentForm.userType,
    );

    state = state.copyWith(signupForm: updatedForm);
  }

  Future<void> updateLoginForm({String? phoneNumber, String? otp}) async {
    final currentForm = state.loginForm;

    final updatedForm = currentForm.copyWith(
      phoneNumber: phoneNumber ?? currentForm.phoneNumber,
      otp: otp ?? currentForm.otp,
    );

    state = state.copyWith(loginForm: updatedForm);
  }

  Future<void> exit() async {
    switch (state.status) {
      case SignupStatusEnum.initial:
      case SignupStatusEnum.addName:
      case SignupStatusEnum.addDOB:
      case SignupStatusEnum.addHeight:
      case SignupStatusEnum.addSex:
      case SignupStatusEnum.addPhoneNumber:
      case SignupStatusEnum.verifyPhoneNumber:
        ref.read(routerProvider).go('/login-or-signup');
        break;
      case SignupStatusEnum.done:
        ref.read(routerProvider).go('/home');
        break;
    }
    ref.invalidateSelf();
  }
}

final signupProvider = NotifierProvider<SignupNotifier, SignupModel>(
  () => SignupNotifier(),
);
