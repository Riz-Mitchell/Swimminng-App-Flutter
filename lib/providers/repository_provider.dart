import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/infrastructure/api.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/auth_repository.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/swim_repository.dart';
import 'package:swimming_app_frontend/shared/infrastructure/repository/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final api = ref.read(apiClientProvider);
  return UserRepository(api);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(apiClientProvider);
  return AuthRepository(api);
});

final swimRepositoryProvider = Provider<SwimRepository>((ref) {
  final api = ref.read(apiClientProvider);
  return SwimRepository(api);
});
