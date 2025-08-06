import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/progress_bar_status_enum.dart';

final progressBarStatusLogSwimsProvider = StateProvider<ProgressBarStatusEnum>(
  (ref) => ProgressBarStatusEnum.selectPoolType,
);
