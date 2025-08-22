import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/enum/event_enum.dart';

final selectedEventLogbookProvider = StateProvider<EventEnum>(
  (ref) => EventEnum.none,
);
