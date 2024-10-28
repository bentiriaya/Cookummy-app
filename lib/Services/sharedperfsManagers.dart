import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedperfManager extends GetxService{

  late SharedPreferences preferences;

  Future<SharedperfManager> init()async{
    preferences=await SharedPreferences.getInstance();
    return this;
  }
  // Get a string value
  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Save a list of strings
  Future<void> saveStringList(String key, List<String> values) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values);
  }
  // Get a list of strings
  Future<List<String>?> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // Save an integer value
  Future<void> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  // Get an integer value
  Future<int?> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get a boolean value
  Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}