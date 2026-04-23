import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<SharedPreferences>? _prefs = SharedPreferences.getInstance();

  static Future<SharedPreferences> _getPrefInstance() async {
    _prefs ??= SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<bool> setString(String key, String val) async {
    return _getPrefInstance().then((value) {
      return value.setString(key, val);
    });
  }

  static Future<bool> setStringList(String key, List<String> val) async {
    return _getPrefInstance().then((value) {
      return value.setStringList(key, val);
    });
  }

  gettStringList(String key) async {
    return _getPrefInstance().then((value) {
      return value.getStringList(key);
    });
  }

  static Future<String?> getString(String key) async {
    return _getPrefInstance().then((value) {
      return value.getString(key);
    }).catchError((error, stackTrace) {
      return 'error';
    });
  }

  static Future<void> clear({String? key}) async {
    if (key == null) {
      return await _getPrefInstance().then((value) => value.clear());
    }
    return await _getPrefInstance().then((value) => value.remove(key));
  }
}
