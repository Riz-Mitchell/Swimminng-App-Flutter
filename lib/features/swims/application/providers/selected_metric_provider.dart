import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/swims/enum/metric_type_enum.dart';

final selectedMetricProvider = StateProvider<MetricType>(
  (ref) => MetricType.pbTime,
);
