import 'package:flutter/material.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_sex_enum.dart';
import 'package:swimming_app_frontend/features/signup/domain/enum/selected_user_type_enum.dart';

@immutable
class SignupFormModel {
  final String name;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final double? height;
  final SelectedSexEnum sex;
  final String? email;
  final SelectedUserTypeEnum userType;

  const SignupFormModel({
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    this.height,
    this.email,
    required this.sex,
    required this.userType,
  });

  SignupFormModel copyWith({
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    double? height,
    String? email,
    SelectedSexEnum? sex,
    SelectedUserTypeEnum? userType,
  }) {
    return SignupFormModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      email: email ?? this.email,
      sex: sex ?? this.sex,
      userType: userType ?? this.userType,
    );
  }
}
