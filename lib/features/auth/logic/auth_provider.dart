import 'package:flutter_riverpod/flutter_riverpod.dart';

// Optional: Expand this to include user info if needed later
enum AuthStatus { unknown, loggedIn, loggedOut }

class AuthController extends StateNotifier<AuthStatus> {
  AuthController() : super(AuthStatus.unknown);

  /// Simulate checking token / session from local storage or secure storage
  Future<bool> checkIfLoggedIn() async {
    // Replace this with real logic (e.g. SharedPreferences, SecureStorage, API check)
    await Future.delayed(const Duration(milliseconds: 500));
    print('Checking if user is logged in...');

    final token = await _readToken(); // Simulated fetch
    final isLoggedIn = token != null && token.isNotEmpty;

    state = isLoggedIn ? AuthStatus.loggedIn : AuthStatus.loggedOut;
    return isLoggedIn;
  }

  Future<String?> _readToken() async {
    // Simulate storage lookup
    return Future.value(null); // or return "token123" to simulate logged in
  }

  void logout() {
    state = AuthStatus.loggedOut;
    // Remove token from storage
  }

  void login() {
    state = AuthStatus.loggedIn;
    // Save token to storage
  }
}

final authProvider = StateNotifierProvider<AuthController, AuthStatus>((ref) {
  return AuthController();
});
