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

  bool isPhoneNumberValid() {
    print('Validating phone number: $phoneNumber');
    print('phoneNumber length: ${phoneNumber.length}');
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneNumber.length == 12;
  }
}
