import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';

class VerifyForm extends Notifier<OTPReqDTO> {
  @override
  OTPReqDTO build() => OTPReqDTO(phoneNum: '');

  void setPhoneNum(String phoneNum) {
    state = state.copyWith(phoneNum: phoneNum);
  }
}

final verifyFormProvider = NotifierProvider<VerifyForm, OTPReqDTO>(() {
  return VerifyForm();
});
