import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/status_log_swim_enum.dart';

final progressBarStatusLogSwimsProvider = StateProvider<StatusLogSwimsEnum>(
  (ref) => StatusLogSwimsEnum.selectPoolType,
);
