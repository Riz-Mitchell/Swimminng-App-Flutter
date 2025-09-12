import 'dart:io';

import 'package:mime/mime.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/auth_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/image_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/user_entity.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/auth_repository.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/image_repository.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/user_repository.dart';

class UserService {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final ImageRepository _imageRepository;

  UserService(
    this._userRepository,
    this._authRepository,
    this._imageRepository,
  );

  Future<GetUserEntity> signupUserAsync(SignupFormModel signupForm) async {
    // Map model to entity
    final otpEntity = AuthMapper.signupFormModelToEntity(signupForm);
    final newUserEntity = UserMapper.signupFormModelToEntity(signupForm);

    final newUser = await _userRepository.createUserAsync(newUserEntity);

    return newUser;
  }

  Future<bool> requestOtpAsync(String phoneNumber) async {
    final otpSchema = OtpEntity(phoneNumber: phoneNumber);

    return await _authRepository.generateOTP(otpSchema);
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
    final success = await _authRepository.logoutUserAsync(userId);
    if (success) {
      print('inside logoutUserAsync, logout endpoint successful');
    } else {
      print('Logout endpoint failed inside logoutUserAsync');
    }
    return success;
  }

  Future<GetUserEntity> getCurrentUser(String userId) async {
    return await _userRepository.getUserAsync(userId);
  }

  Future<GetUserEntity> updateUserAsync(
    String userId,
    UpdateUserEntity updatedUser,
  ) async {
    return await _userRepository.updateUserAsync(userId, updatedUser);
  }

  Future<void> changeUserPfpAsync(String userId, File imageFile) async {
    final mimeType =
        lookupMimeType(imageFile.path) ?? 'application/octet-stream';

    // First request a presigned URL from the backend
    final s3UploadInfo = await _imageRepository.requestProfileImageUpload(
      CreateImageReqEntity(contentType: mimeType),
    );

    // Then upload the image to the presigned URL
    final uploadSuccess = await _imageRepository.uploadProfileImage(
      s3UploadInfo.uploadUrl,
      imageFile,
    );

    // Extract key to use to confirm with backend
    final key = s3UploadInfo.key;

    // Finally, confirm and update the user's profile picture URL in the backend
    if (uploadSuccess) {
      final confirmSuccess = await _imageRepository.confirmProfileImageUpload(
        ConfirmImageReqEntity(key: key),
      );

      if (confirmSuccess) {
        // Update the user's profile with the new image key
        print('Success confirmed image upload with backend');
      } else {
        print('Failed to confirm image upload with backend');
      }
    } else {
      print('Failed to upload image to S3');
    }
  }
}
