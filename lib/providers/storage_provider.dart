import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swimming_app_frontend/shared/storage/storage.dart';

final storageProvider = Provider<Storage>((ref) {
  return Storage();
});
