import 'package:flutter_riverpod/flutter_riverpod.dart';

final navDirectionProvider = StateProvider<NavigationDirection>(
  (ref) => NavigationDirection.forward,
);

enum NavigationDirection { forward, backward }
