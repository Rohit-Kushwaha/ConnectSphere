// import 'package:encrypt_shared_preferences/provider.dart';

// class SharedPrefHelper {
//   // Private constructor for Singleton
//   SharedPrefHelper._privateConstructor();

//   // Single instance
//   static final SharedPrefHelper _instance =
//       SharedPrefHelper._privateConstructor();

//   // Factory to return the same instance
//   factory SharedPrefHelper() {
//     return _instance;
//   }

//   // EncryptedSharedPreferences instance
//   EncryptedSharedPreferences _prefs;

// // Initialize EncryptedSharedPreferences instance
//   Future<void> init() async {
//     _prefs = EncryptedSharedPreferences.getInstance();
//   }

//   // Method to save data
//   Future<void> saveData(String key, dynamic value) async {
//     if (value is String) {
//       await _prefs.setString(key, value);
//     } else if (value is int) {
//       await _prefs.setInt(key, value);
//     } else if (value is bool) {
//       await _prefs.setBoolean(key, value);
//     } else if (value is double) {
//       await _prefs.setDouble(key, value);
//     } else if (value is List<String>) {
//       await _prefs.setStringList(key, value);
//     } else {
//       throw Exception("Invalid data type");
//     }
//   }

//   // Method to get data
//   Future<dynamic> getData(String key) async {
//     return _prefs.get(key);
//   }

//   // Method to remove data
//   Future<void> removeData(String key) async {
//     await _prefs.remove(key);
//   }

//   // Method to clear all data
//   Future<void> clearAllData() async {
//     await _prefs.clear();
//   }
// }

// /// Usage Example
// /// Saving data
// // await SharedPrefHelper().saveData('username', 'JohnDoe');
// // await SharedPrefHelper().saveData('age', 25);
// // await SharedPrefHelper().saveData('isLoggedIn', true);

// /// Getting data
// // String? username = await SharedPrefHelper().getData('username') as String?;
// // int? age = await SharedPrefHelper().getData('age') as int?;
// // bool? isLoggedIn = await SharedPrefHelper().getData('isLoggedIn') as bool?;

// /// Removing data
// // await SharedPrefHelper().removeData('username');

// /// Clearing all data
// // await SharedPrefHelper().clearAllData();
