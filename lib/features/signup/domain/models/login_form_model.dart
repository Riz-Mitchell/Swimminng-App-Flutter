import 'package:flutter/material.dart';

@immutable
class LoginFormModel {
  final String phoneNumber;
  final String otp;

  const LoginFormModel({required this.phoneNumber, required this.otp});

  LoginFormModel copyWith({String? phoneNumber, String? otp}) {
    return LoginFormModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
    );
  }
}
