import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/metric_type_enum.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/infrastructure/models/swim_model.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';

final swimGraphFilterProvider =
    StateProvider<({TimePeriod range, MetricType metric})>((ref) {
      return (range: TimePeriod.week, metric: MetricType.time);
    });

// final swimGraphDataProvider =
//     FutureProvider.family<
//       SwimGraphModel,
//       ({TimePeriod timePeriod, MetricType metric})
//     >((ref, filter) async {
//       final service = ref.read(swimServiceProvider);

//       final data = await service.getSwimsByTimePeriodAsync(filter.timePeriod);
//     });

final swimGraphControllerProvider =
    AutoDisposeAsyncNotifierProvider<SwimGraphController, SwimGraphState>(
      () => SwimGraphController(),
    );

class SwimGraphState {
  final TimePeriod selectedPeriod;
  final Map<TimePeriod, List<GetSwimResDTO>> cachedData;

  SwimGraphState({required this.selectedPeriod, required this.cachedData});

  SwimGraphState copyWith({
    TimePeriod? selectedPeriod,
    Map<TimePeriod, List<GetSwimResDTO>>? cachedData,
  }) {
    return SwimGraphState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      cachedData: cachedData ?? this.cachedData,
    );
  }
}

class SwimGraphController extends AutoDisposeAsyncNotifier<SwimGraphState> {
  @override
  Future<SwimGraphState> build() async {
    final service = ref.read(swimServiceProvider);

    final weekData = await service.getSwimsByTimePeriodAsync(TimePeriod.week);

    return SwimGraphState(
      selectedPeriod: TimePeriod.week,
      cachedData: {TimePeriod.week: weekData},
    );
  }

  Future<void> selectTimePeriod(TimePeriod timePeriod) async {
    final service = ref.read(swimServiceProvider);
    final currentState = state.valueOrNull;

    if (currentState == null) return;

    // Check if data exists
    if (currentState.cachedData.containsKey(timePeriod)) {
      state = AsyncData(currentState.copyWith(selectedPeriod: timePeriod));
      return;
    }

    // Trigger async loading so we can check that in the widget
    state = AsyncLoading();
    try {
      // Get next selected time period data and add to cache
      final data = await service.getSwimsByTimePeriodAsync(timePeriod);
      final updatedCache = currentState.cachedData;
      updatedCache[timePeriod] = data;

      state = AsyncData(
        currentState.copyWith(
          selectedPeriod: timePeriod,
          cachedData: updatedCache,
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
