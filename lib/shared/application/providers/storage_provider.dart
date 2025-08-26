import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences prefs;

  Storage(this.prefs);

  // USER ID
  Future<void> setUserId(String userId) async {
    await prefs.setString('userId', userId);
  }

  String? get userId => prefs.getString('userId');

  Future<void> clearUserId() async {
    await prefs.remove('userId');
  }

  // DARK MODE
  Future<void> setDarkMode(bool isDark) async {
    await prefs.setBool('darkMode', isDark);
  }

  bool get isDarkMode => prefs.getBool('darkMode') ?? false;

  // CLEAR ALL
  Future<void> clearAll() async {
    await prefs.clear();
  }
}

final storageProvider = FutureProvider<Storage>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return Storage(prefs);
});
