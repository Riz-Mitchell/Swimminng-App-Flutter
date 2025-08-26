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
    if (await userService.checkLoginStatusAsync() && storage.userId != null) {
      return LoginStatus.loggedIn;
    } else {
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

    print('attempting to logout, userId from storage: $userId');

    if (userId == null) {
      print('attempting to logout when userId not set in storage');
    } else {
      try {
        print('inside logout try block, userId: $userId');
        await userService.handleLogoutAsync(userId);
        await storage.clearUserId();
      } catch (e) {
        print('error during logout: $e');
      }
    }

    print('logged out, setting state to loggedOut');

    state = AsyncData(LoginStatus.loggedOut);
    ref.read(routerProvider).go('/login-or-signup');
  }

  Future<void> login(LoginFormModel loginForm) async {
    final storage = await ref.read(storageProvider.future);
    final userService = ref.read(userServiceProvider);
    print('LOGGING IN');

    String? userId = await userService.verifyUserAsync(loginForm);

    if (userId != null) {
      print('login successful, userId: $userId');
      storage.setUserId(userId);
    } else {
      print('login failed, userId is null');
    }
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, LoginStatus>(() => AuthController());
