import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _secureStorage = FlutterSecureStorage();

class TokenStorage {
  static const _keyAccess = 'access_token';
  static const _keyRefresh = 'refresh_token';

  Future<String?> readAccess() => _secureStorage.read(key: _keyAccess);
  Future<String?> readRefresh() => _secureStorage.read(key: _keyRefresh);

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await Future.wait([
      _secureStorage.write(key: _keyAccess, value: access),
      _secureStorage.write(key: _keyRefresh, value: refresh),
    ]);
  }

  Future<void> clear() async {
    await Future.wait([
      _secureStorage.delete(key: _keyAccess),
      _secureStorage.delete(key: _keyRefresh),
    ]);
  }
}
