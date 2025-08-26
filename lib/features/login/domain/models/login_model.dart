import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/login/domain/enum/login_status_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';

@immutable
class LoginModel {
  final LoginStatusEnum status;
  final LoginFormModel loginForm;

  const LoginModel({required this.status, required this.loginForm});

  LoginModel copyWith({LoginStatusEnum? status, LoginFormModel? loginForm}) {
    return LoginModel(
      status: status ?? this.status,
      loginForm: loginForm ?? this.loginForm,
    );
  }
}
