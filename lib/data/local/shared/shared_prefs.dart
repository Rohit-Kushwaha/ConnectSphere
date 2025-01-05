import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._privateConstructor();

  static final SharedPrefHelper instance =
      SharedPrefHelper._privateConstructor();

  SharedPreferences? _prefs;
  bool _isInitialized = false;

  Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception(
          "SharedPrefHelper has not been initialized. Call init() first.");
    }
    return _prefs!;
  }

  Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else {
      throw Exception("Invalid data type");
    }
  }

  dynamic getData(String key, {dynamic defaultValue}) {
    return prefs.get(key) ?? defaultValue;
  }

  String? getString(String key) => prefs.getString(key);
  int? getInt(String key) => prefs.getInt(key);
  bool? getBool(String key) => prefs.getBool(key);
  double? getDouble(String key) => prefs.getDouble(key);
  List<String>? getStringList(String key) => prefs.getStringList(key);

  Future<bool> removeData(String key) async {
    return prefs.remove(key);
  }

  Future<bool> clearAllData() async {
    return prefs.clear();
  }
}

/// Saving data
/// await SharedPrefHelper.instance.saveData('accessToken', 'your-token');

/// Get data
// String? token = SharedPrefHelper.instance.getString('accessToken');


/// Remove data
// await SharedPrefHelper.instance.removeData('accessToken');

/// Clear data
// await SharedPrefHelper.instance.clearAllData();


// Key Features in Final Version
// Thread-safe initialization.
// Simplified and strongly-typed access methods.
// Default value support for getData.
// Improved readability and usability.