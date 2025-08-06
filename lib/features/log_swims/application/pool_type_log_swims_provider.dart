import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/features/log_swims/domain/enum/selected_pool_type_enum.dart';

final selectedPoolTypeProvider = StateProvider<SelectedPoolTypeEnum>(
  (ref) => SelectedPoolTypeEnum.unselected,
);
