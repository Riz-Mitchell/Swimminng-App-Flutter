import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

class LoginUserReqNotifier extends Notifier<LoginReqDTO> {
  @override
  LoginReqDTO build() => LoginReqDTO(phoneNum: '', otp: '');

  void setPhoneNum(String phoneNum) {
    state = state.copyWith(phoneNum: phoneNum);
  }

  void setOTP(String otp) {
    state = state.copyWith(otp: otp);
  }

  Future<bool> submitAsync() async {
    final userService = ref.read(userServiceProvider);

    return await userService.verifyUserAndLogin(state);
  }
}

final loginUserReqProvider =
    NotifierProvider<LoginUserReqNotifier, LoginReqDTO>(
      () => LoginUserReqNotifier(),
    );
