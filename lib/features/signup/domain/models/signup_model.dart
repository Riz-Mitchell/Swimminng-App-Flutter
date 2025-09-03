import 'package:flutter/cupertino.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/signup_status_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';

@immutable
class SignupModel {
  final SignupStatusEnum status;
  final SignupFormModel signupForm;
  final LoginFormModel loginForm;
  final String? errorMessage;

  const SignupModel({
    required this.status,
    required this.signupForm,
    required this.loginForm,
    this.errorMessage,
  });

  SignupModel copyWith({
    SignupStatusEnum? status,
    SignupFormModel? signupForm,
    LoginFormModel? loginForm,
    String? errorMessage,
  }) {
    return SignupModel(
      status: status ?? this.status,
      signupForm: signupForm ?? this.signupForm,
      loginForm: loginForm ?? this.loginForm,
      errorMessage: errorMessage,
    );
  }
}
