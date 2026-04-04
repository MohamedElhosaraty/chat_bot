import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static SharedPreferences? _prefs;

  /// Init مرة واحدة بس (تتنادى في main)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return _prefs!;
  }

  /// SET DATA
  static Future<void> setData(String key, dynamic value) async {

    switch (value) {
      case String():
        await prefs.setString(key, value);
        break;
      case int():
        await prefs.setInt(key, value);
        break;
      case bool():
        await prefs.setBool(key, value);
        break;
      case double():
        await prefs.setDouble(key, value);
        break;
      default:
        throw Exception("Unsupported type");
    }
  }

  /// GET
  static Future<String> getString(String key) async =>
      prefs.getString(key) ?? '';

  static Future<int> getInt(String key) async =>
      prefs.getInt(key) ?? 0;

  static Future<double> getDouble(String key) async =>
      prefs.getDouble(key) ?? 0.0;

  static Future<bool> getBool(String key) async =>
      prefs.getBool(key) ?? false;

  /// REMOVE
  static Future<void> removeData(String key) async {
    await prefs.remove(key);
  }

  /// CLEAR
  static Future<void> clearAllData() async {
    await prefs.clear();
  }

  /// SECURE STORAGE
  static const FlutterSecureStorage _secure = FlutterSecureStorage();

  static Future<void> setSecuredString(String key, String value) async {
    await _secure.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    return await _secure.read(key: key) ?? '';
  }

  static Future<void> clearAllSecuredData() async {
    await _secure.deleteAll();
  }
}