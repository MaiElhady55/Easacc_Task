import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefServices {
  final SharedPreferences sharedPreferences;

  SharedPrefServices({required this.sharedPreferences});

  Future<bool?> saveData(
    final String key,
    final dynamic value,
  ) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return null;
  }

  dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clearData(
  ) async {
    return await sharedPreferences.clear();
  }
}
