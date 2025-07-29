import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';
import 'package:swimming_app_frontend/features/home/domain/models/home_model.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';

final homePageDataProvider = FutureProvider<HomeModel>((ref) async {
  final service = ref.read(swimServiceProvider);

  final GetSwimResDTO latestSwim = await service.getLatestSwim();

  return HomeModel(latestSwimData: latestSwim);
});
