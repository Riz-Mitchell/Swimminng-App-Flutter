import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/api.dart';
import 'package:swimming_app_frontend/api/repository/auth_repository.dart';
import 'package:swimming_app_frontend/api/repository/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final api = ref.read(apiClientProvider);
  return UserRepository(api);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(apiClientProvider);
  return AuthRepository(api);
});
