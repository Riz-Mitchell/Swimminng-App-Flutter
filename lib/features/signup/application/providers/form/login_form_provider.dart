import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/domain/models/auth_model.dart';

class LoginForm extends Notifier<LoginReqDTO> {
  @override
  LoginReqDTO build() => LoginReqDTO(phoneNum: '', otp: '');

  void setPhoneNum(String phoneNum) {
    state = state.copyWith(phoneNum: phoneNum);
  }

  void setOTP(String otp) {
    state = state.copyWith(otp: otp);
  }
}

final loginFormProvider = NotifierProvider<LoginForm, LoginReqDTO>(
  () => LoginForm(),
);
