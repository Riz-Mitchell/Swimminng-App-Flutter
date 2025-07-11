import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _instance = Storage._internal();
  factory Storage() => _instance;

  SharedPreferences? _prefs;

  Storage._internal();

  /// Call this once during app startup (e.g., in main)
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ==========================
  // USER ID
  // ==========================

  Future<void> setUserId(String userId) async {
    await _ensurePrefs();
    await _prefs!.setString('userId', userId);
  }

  String? get userId => _prefs?.getString('userId');

  Future<void> clearUserId() async {
    await _ensurePrefs();
    await _prefs!.remove('userId');
  }

  // ==========================
  // DARK MODE
  // ==========================

  Future<void> setDarkMode(bool isDark) async {
    await _ensurePrefs();
    await _prefs!.setBool('darkMode', isDark);
  }

  bool get isDarkMode => _prefs?.getBool('darkMode') ?? false;

  // ==========================
  // CLEAR ALL
  // ==========================

  Future<void> clearAll() async {
    await _ensurePrefs();
    await _prefs!.clear();
  }

  // ==========================
  // PRIVATE HELPERS
  // ==========================

  Future<void> _ensurePrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}

final globalStorage = Storage();
