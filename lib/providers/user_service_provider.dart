import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/domain/services/user_service.dart';
import 'package:swimming_app_frontend/providers/repository_provider.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final userRepo = ref.read(userRepositoryProvider);
  final authRepo = ref.read(authRepositoryProvider);
  return UserService(userRepo, authRepo);
});
