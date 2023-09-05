import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  // Constructor
  static Future<SharedPreferences> init() async => _instance = await SharedPreferences.getInstance();

  // Setters
  static Future<bool> setInt(String key, int value) async => await _instance.setInt(key, value);
  static Future<bool> setBool(String key, bool value) async => await _instance.setBool(key, value);
  static Future<bool> setDouble(String key, double value) async => await _instance.setDouble(key, value);
  static Future<bool> setString(String key, String value) async => await _instance.setString(key, value);
  static Future<bool> setStringList(String key, List<String> value) async => await _instance.setStringList(key, value);

  // Getters
  static Object? get(String key) => _instance.get(key);

  static int? getInt(String key) => _instance.getInt(key);
  static bool? getBool(String key) => _instance.getBool(key);
  static double? getDouble(String key) => _instance.getDouble(key);
  static String? getString(String key) => _instance.getString(key);
  static List<String>? getStringList(String key) => _instance.getStringList(key);

  // Miscellanous Functions
  static Future<bool> clear() => _instance.clear();
  static Future<bool> remove(String key) => _instance.remove(key);

  static Set<String> getKeys() => _instance.getKeys();
  static bool hasKey(String key) => _instance.containsKey(key);
}
