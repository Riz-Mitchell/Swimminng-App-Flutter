import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/metric_type_enum.dart';
import 'package:swimming_app_frontend/features/swims/enum/time_period_enum.dart';
import 'package:swimming_app_frontend/features/swims/domain/models/swim_model.dart';
import 'package:swimming_app_frontend/providers/swim_service_provider.dart';

final swimGraphFilterProvider =
    StateProvider<({TimePeriod range, MetricType metric})>((ref) {
      return (range: TimePeriod.week, metric: MetricType.pbTime);
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
  final Map<TimePeriod, SwimGraphModel> cachedData;

  SwimGraphState({required this.selectedPeriod, required this.cachedData});

  SwimGraphState copyWith({
    TimePeriod? selectedPeriod,
    Map<TimePeriod, SwimGraphModel>? cachedData,
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

    final dayData = await service.getSwimsByTimePeriodAsync(TimePeriod.day);

    final dayGraphModel = SwimGraphModel(
      resData: dayData,
      timePeriod: TimePeriod.day,
    );

    // Handle processing of data for what we need

    return SwimGraphState(
      selectedPeriod: TimePeriod.day,
      cachedData: {TimePeriod.day: dayGraphModel},
    );
  }

  TimePeriod? get selectedPeriod => state.valueOrNull?.selectedPeriod;

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
      final timePeriodGraphModel = SwimGraphModel(
        resData: data,
        timePeriod: timePeriod,
      );
      final updatedCache = currentState.cachedData;
      updatedCache[timePeriod] = timePeriodGraphModel;

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

  List<FlSpot> getGraphSpots() {
    final current = state.valueOrNull;
    if (current == null) return [];

    final currentGraphModel = current.cachedData[current.selectedPeriod];

    if (currentGraphModel == null) return [];

    return currentGraphModel.spots;
  }

  double getXMax() {
    final currentGraph = currentGraphData;
    if (currentGraph == null) return 0.0;
    return currentGraph.xMax;
  }

  double getXMin() {
    final currentGraph = currentGraphData;
    if (currentGraph == null) return 0.0;
    return currentGraph.xMin;
  }

  Map<double, String> getSpotsDisplayTextMap() {
    final current = state.valueOrNull;
    if (current == null) return {};

    final currentGraphModel = current.cachedData[current.selectedPeriod];

    if (currentGraphModel == null) return {};

    return currentGraphModel.spotsDisplayTextMap;
  }

  SwimGraphModel? get currentGraphData {
    final current = state.valueOrNull;
    if (current == null) return null;
    return current.cachedData[current.selectedPeriod];
  }

  String getStartStr() {
    final current = state.valueOrNull;
    if (current == null) return '';

    final currentGraphModel = current.cachedData[current.selectedPeriod];

    if (currentGraphModel == null) return '';

    return currentGraphModel.xMinDisplayStr;
  }

  String getEndStr() {
    final current = state.valueOrNull;
    if (current == null) return '';

    final currentGraphModel = current.cachedData[current.selectedPeriod];

    if (currentGraphModel == null) return '';

    return currentGraphModel.xMaxDisplayStr;
  }

  String getAverageYDisplayStr() {
    final current = state.valueOrNull;
    if (current == null) return '';

    final currentGraphModel = current.cachedData[current.selectedPeriod];

    if (currentGraphModel == null) return '';

    return currentGraphModel.averageYDisplayStr;
  }
}
