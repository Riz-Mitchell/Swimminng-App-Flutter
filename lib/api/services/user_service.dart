import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';
import 'package:swimming_app_frontend/api/repository/auth_repository.dart';
import 'package:swimming_app_frontend/api/repository/user_repository.dart';

class UserService {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  UserService(this._userRepository, this._authRepository);

  Future<GetUserResDTO> createUserAndSendVerifyCode(
    CreateUserReqDTO schema,
  ) async {
    final newUser = await _userRepository.createUserReq(schema);

    OTPRequest otpRequest = OTPRequest(phoneNum: schema.phoneNumber);

    await _authRepository.generateOTP(otpRequest);

    return newUser;
  }

  Future<bool> verifyUserAndLogin(LoginRequest schema) async {
    try {
      await _authRepository.verifyOTP(schema);
      return true; // Login successful
    } catch (e) {
      // Handle login failure, e.g., show error message to user
      return false;
    }
  }
}
