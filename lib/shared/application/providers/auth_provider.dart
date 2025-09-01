import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/login_form_model.dart';
import 'package:swimming_app_frontend/features/signup/domain/models/signup_form_model.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/router_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/storage_provider.dart';

enum LoginStatus { loggedIn, loggedOut }

class AuthController extends AsyncNotifier<LoginStatus> {
  @override
  Future<LoginStatus> build() async {
    final userService = ref.read(userServiceProvider);
    final storage = await ref.watch(storageProvider.future);
    print('storage userId in auth provider build: ${storage.userId}');
    final apiLoginStatus = await userService.checkLoginStatusAsync();
    print('apiLoginStatus in auth provider build: $apiLoginStatus');

    if (apiLoginStatus && storage.userId != null) {
      return LoginStatus.loggedIn;
    } else {
      if (apiLoginStatus && storage.userId == null) {
        print('apiLoginStatus true but userId null, logging out');
        await logout();
      }

      return LoginStatus.loggedOut;
    }
  }

  Future<void> signup(SignupFormModel signupForm) async {
    final userService = ref.read(userServiceProvider);

    await userService.signupUserAsync(signupForm);

    await userService.requestOtpAsync(signupForm.phoneNumber);
  }

  Future<void> requestOtp(String phoneNumber) async {
    final userService = ref.read(userServiceProvider);

    await userService.requestOtpAsync(phoneNumber);
  }

  Future<void> logout() async {
    final userService = ref.read(userServiceProvider);
    final storage = await ref.read(storageProvider.future);

    final userId = storage.userId;

    if (userId == null || userId.isEmpty) {
      await userService.deleteAuthCookiesAsync();
      state = AsyncData(LoginStatus.loggedOut);
      return;
    } else {
      print('userId found in storage: $userId');
      await userService.logoutUserAsync(userId);
      await storage.clearUserId();
      await userService.deleteAuthCookiesAsync();
      state = AsyncData(LoginStatus.loggedOut);
      return;
    }
  }

  Future<void> login(LoginFormModel loginForm) async {
    final storage = await ref.read(storageProvider.future);
    final userService = ref.read(userServiceProvider);
    print('LOGGING IN');

    String? userId = await userService.verifyUserAsync(loginForm);

    if (userId != null) {
      print('login successful, userId: $userId');
      storage.setUserId(userId);
      state = AsyncData(LoginStatus.loggedIn);
    } else {
      print('login failed, userId is null');
      state = AsyncData(LoginStatus.loggedOut);
    }
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, LoginStatus>(() => AuthController());
