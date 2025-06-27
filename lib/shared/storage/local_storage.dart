import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> isFirstLaunch() async {
    final sPreferences = await SharedPreferences.getInstance();
    final seen = sPreferences.getBool('seen') ?? false;
    if (!seen) {
      await sPreferences.setBool('seen', true);
    }
    return !seen;
  }

  static Future<bool> isLoggedIn() async {
    final sPreferences = await SharedPreferences.getInstance();
    return sPreferences.getBool('loggedIn') ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final sPreferences = await SharedPreferences.getInstance();
    await sPreferences.setBool('loggedIn', value);
  }
}
