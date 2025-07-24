import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/form/login_form_provider.dart';
import 'package:swimming_app_frontend/features/signup/application/providers/form/signup_form_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/form/verify_form_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/storage_provider.dart';

enum LoginStatus { loggedIn, loggedOut }

class AuthController extends AsyncNotifier<LoginStatus> {
  @override
  Future<LoginStatus> build() async {
    final userService = ref.read(userServiceProvider);
    final storage = ref.read(storageProvider);
    if (await userService.checkLoginStatus() && storage.userId != null) {
      return LoginStatus.loggedIn;
    } else {
      return LoginStatus.loggedOut;
    }
  }

  Future<void> signup() async {
    final userService = ref.read(userServiceProvider);
    final postUserReq = ref.read(signupFormProvider);

    final otpReqNotifier = ref.read(verifyFormProvider.notifier);

    await userService.signupUser(postUserReq);

    otpReqNotifier.setPhoneNum(postUserReq.phoneNumber);

    await userService.requestOtp(ref.read(verifyFormProvider));
  }

  Future<void> requestOtp() async {
    final userService = ref.read(userServiceProvider);

    await userService.requestOtp(ref.read(verifyFormProvider));
  }

  Future<void> logout() async {
    final userService = ref.read(userServiceProvider);
    final storage = ref.read(storageProvider);

    final userId = storage.userId;

    if (userId == null) {
      print('attempting to logout when userId not set in storage');
    } else {
      await userService.handleLogout(userId);
      await storage.clearUserId();
    }

    state = AsyncData(LoginStatus.loggedOut);
  }

  Future<void> login() async {
    final storage = ref.read(storageProvider);
    final userService = ref.read(userServiceProvider);
    final loginUserReq = ref.read(loginFormProvider);

    String? userId = await userService.verifyUser(loginUserReq);

    if (userId != null) {
      storage.setUserId(userId);
    }
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, LoginStatus>(() => AuthController());
