import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/profile/domain/models/profile_model.dart';
import 'package:swimming_app_frontend/providers/user_service_provider.dart';
import 'package:swimming_app_frontend/shared/application/providers/storage_provider.dart';
import 'package:swimming_app_frontend/shared/infrastructure/entities/swim_entity.dart';

class ProfileNotifier extends AsyncNotifier<ProfileModel> {
  @override
  build() async {
    final storage = await ref.read(storageProvider.future);
    final userId = storage.userId;
    final user = await ref.read(userServiceProvider).getCurrentUser(userId!);

    final pbSwimsList = <GetSwimEntity>[];

    return ProfileModel(user: user, pbSwimsList: pbSwimsList);
  }
}

final profileProvider = AsyncNotifierProvider<ProfileNotifier, ProfileModel>(
  ProfileNotifier.new,
);
