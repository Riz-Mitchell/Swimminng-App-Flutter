import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateSignupProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
