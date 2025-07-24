import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/domain/services/swim_service.dart';
import 'package:swimming_app_frontend/providers/repository_provider.dart';

final swimServiceProvider = Provider<SwimService>((ref) {
  final swimRepo = ref.read(swimRepositoryProvider);
  return SwimService(swimRepo);
});
