import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';

final loginStatusProvider = FutureProvider<bool>((ref) async {
  final userService = ref.read(userServiceProvider);
  return await userService.checkLoginStatus();
});
