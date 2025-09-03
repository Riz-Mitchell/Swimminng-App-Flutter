import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/login/domain/enum/login_status_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';

@immutable
class LoginModel {
  final LoginStatusEnum status;
  final LoginFormModel loginForm;
  final String? errorMessage;

  const LoginModel({
    required this.status,
    required this.loginForm,
    this.errorMessage,
  });

  LoginModel copyWith({
    LoginStatusEnum? status,
    LoginFormModel? loginForm,
    String? errorMessage,
  }) {
    return LoginModel(
      status: status ?? this.status,
      loginForm: loginForm ?? this.loginForm,
      errorMessage: errorMessage,
    );
  }
}
