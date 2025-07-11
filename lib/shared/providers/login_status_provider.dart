import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/user_creation/providers/login_user_req_provider.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';
import 'package:swimming_app_frontend/shared/providers/storage_provider.dart';

enum LoginStatus { loggedIn, loggedOut }

class LoginStatusNotifier extends AsyncNotifier<LoginStatus> {
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

  void logout() async {
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

  void login() async {
    final storage = ref.read(storageProvider);

    bool loginSuccess = await ref
        .read(loginUserReqProvider.notifier)
        .submitAsync();
  }
}

final loginStatusProvider =
    AsyncNotifierProvider<LoginStatusNotifier, LoginStatus>(
      () => LoginStatusNotifier(),
    );
