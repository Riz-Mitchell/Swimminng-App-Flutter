import 'package:swimming_app_frontend/api/models/auth_model.dart';
import 'package:swimming_app_frontend/api/models/user_model.dart';
import 'package:swimming_app_frontend/api/repository/auth_repository.dart';
import 'package:swimming_app_frontend/api/repository/user_repository.dart';

class UserService {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  UserService(this._userRepository, this._authRepository);

  Future<GetUserResDTO> signupUser(CreateUserReqDTO schema) async {
    final newUser = await _userRepository.createUserReq(schema);

    return newUser;
  }

  Future<bool> requestOtp(OTPReqDTO otpSchema) async {
    try {
      await _authRepository.generateOTP(otpSchema);

      return true;
    } catch (e) {
      // Handle otpRequest failure
      return false;
    }
  }

  Future<String?> verifyUser(LoginReqDTO schema) async {
    return await _authRepository.verifyOTP(schema);
  }

  Future<bool> checkLoginStatus() async {
    return await _authRepository.checkLoginStatus();
  }

  Future<bool> handleLogout(String userId) async {
    return await _authRepository.deleteCookiesAndAuthData(userId);
  }
}
