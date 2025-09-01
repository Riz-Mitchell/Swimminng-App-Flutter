import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/auth_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/user_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/auth_repository.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/user_repository.dart';

class UserService {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  UserService(this._userRepository, this._authRepository);

  Future<GetUserEntity> signupUserAsync(SignupFormModel signupForm) async {
    // Map model to entity
    final otpEntity = AuthMapper.signupFormModelToEntity(signupForm);
    final newUserEntity = UserMapper.signupFormModelToEntity(signupForm);

    final newUser = await _userRepository.createUserAsync(newUserEntity);

    return newUser;
  }

  Future<bool> requestOtpAsync(String phoneNumber) async {
    final otpSchema = OtpEntity(phoneNumber: phoneNumber);

    try {
      await _authRepository.generateOTP(otpSchema);

      return true;
    } catch (e) {
      // Handle otpRequest failure
      return false;
    }
  }

  Future<String?> verifyUserAsync(LoginFormModel loginForm) async {
    final loginEntity = AuthMapper.loginFormModelToEntity(loginForm);

    return await _authRepository.verifyOTP(loginEntity);
  }

  Future<bool> checkLoginStatusAsync() async {
    return await _authRepository.checkLoginStatus();
  }

  Future<bool> deleteAuthCookiesAsync() async {
    return await _authRepository.deleteAuthCookiesAsync();
  }

  Future<bool> logoutUserAsync(String userId) async {
    return await _authRepository.logoutUserAsync(userId);
  }
}
