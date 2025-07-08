import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';

final otpReqProvider = StateProvider<OTPReqDTO>((ref) {
  return OTPReqDTO(phoneNum: '');
});

final loginReqProvider = StateProvider<LoginReqDTO>((ref) {
  return LoginReqDTO(phoneNum: '', otp: '');
});
