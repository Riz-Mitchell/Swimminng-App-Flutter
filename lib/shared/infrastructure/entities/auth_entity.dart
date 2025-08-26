import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';

class OtpEntity {
  final String phoneNumber;

  const OtpEntity({required this.phoneNumber});

  OtpEntity copyWith({String? phoneNumber}) {
    return OtpEntity(phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  Map<String, dynamic> toJson() => {'phoneNum': phoneNumber};
}

@immutable
class LoginEntity {
  final String phoneNumber;
  final String otp;

  const LoginEntity({required this.phoneNumber, required this.otp});

  LoginEntity copyWith({String? phoneNumber, String? otp}) {
    return LoginEntity(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toJson() => {'phoneNum': phoneNumber, 'otp': otp};
}

class AuthMapper {
  static OtpEntity signupFormModelToEntity(SignupFormModel model) {
    return OtpEntity(phoneNumber: model.phoneNumber);
  }

  static LoginEntity loginFormModelToEntity(LoginFormModel model) {
    return LoginEntity(phoneNumber: model.phoneNumber, otp: model.otp);
  }
}
