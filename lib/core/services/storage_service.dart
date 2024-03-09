import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service for handling storage operations in local memory or cache.
///
/// This class provides methods to [saveString], [load], and [remove] data from cache.
class StorageService {
  static SharedPreferences? _prefs;

  /// Returns unique key combined with prefix app abbreviation to store in cache.
  static String _getKey(String key) => '${AppConstant.appAbbrPrefix}/$key';

  /// Private constructor to prevent the instantiation of this class.
  StorageService._();

  /// Saves a key-value pair to cache with String value.
  ///
  /// The [key] is prefixed with the app abbreviation before saving.
  /// Returns a [Future<bool>] indicating the success of the operation.
  static Future<bool> saveString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.setString(_getKey(key), value);
  }

  /// get a String value associated with the specified [key] from cache.
  ///
  /// The [key] is prefixed with the app abbreviation before loading.
  /// Returns a [Future<String?>] containing the loaded value.
  static Future<String?> getString(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString(_getKey(key));
  }

  /// Saves a key-value pair to cache.
  ///
  /// The [key] is prefixed with the app abbreviation before saving.
  /// Returns a [Future<bool>] indicating the success of the operation.
  static Future<bool> save(String key, dynamic value) async {
    _prefs ??= await SharedPreferences.getInstance();
    if (value is String) {
      return _prefs!.setString(_getKey(key), value);
    } else if (value is bool) {
      return _prefs!.setBool(_getKey(key), value);
    } else if (value is int) {
      return _prefs!.setInt(_getKey(key), value);
    } else if (value is double) {
      return _prefs!.setDouble(_getKey(key), value);
    } else if (value is List<String>) {
      return _prefs!.setStringList(_getKey(key), value);
    } else {
      return false;
    }
  }

  /// get a value associated with the specified [key] from cache.
  ///
  /// The [key] is prefixed with the app abbreviation before loading.
  /// Returns a [Future<String?>] containing the loaded value.
  static Future<Object?> get(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.get(_getKey(key));
  }

  /// Removes the key-value pair associated with the specified [key] from cache.
  ///
  /// The [key] is prefixed with the app abbreviation before removal.
  /// Returns a [Future<bool?>] indicating the success of the removal operation.
  static Future<bool?> remove(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.remove(_getKey(key));
  }

  /// Returns all keys in the persistent storage.
  static Future<Set<String>> getKeys() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getKeys();
  }

  /// Returns all keys in the persistent storage.
  static Future<bool> removeWithPrefix(String prefix) async {
    var appPrefix = _getKey(prefix);
    var keys = await getKeys();
    bool result = false;
    for (String key in keys) {
      if (key.startsWith(appPrefix)) {
        _prefs?.remove(key);
        result = true;
      }
    }
    return result;
  }
}
