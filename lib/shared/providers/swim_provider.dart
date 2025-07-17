import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/api/services/swim_service.dart';
import 'package:swimming_app_frontend/features/swims/infrastructure/models/swim_model.dart';
import 'package:swimming_app_frontend/features/swims/providers/form/add_swim_form.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';

class SwimController extends AsyncNotifier<void> {
  late final SwimService swimService;

  @override
  Future<void> build() async {
    swimService = ref.read(swimServiceProvider);
  }

  Future<void> submitSwim() async {
    state = const AsyncLoading();
    try {
      final CreateSwimReqDTO addSwimForm = ref.read(addSwimFormProvider);
      await swimService.createSwim(addSwimForm);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final swimControllerProvider = AsyncNotifierProvider<SwimController, void>(
  () => SwimController(),
);
