import 'package:flutter/cupertino.dart';
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

  //pour icone
  Future<Icon?> getIcon(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve icon data from SharedPreferences
    String? iconData = prefs.getString(key);

    if (iconData == null) {
      return null; // Return null if no icon is found
    }

    // Deserialize icon data to create an Icon
    Icon icon = _deserializeIcon(iconData);
    return icon;
  }

  Future<void> saveIcon(String key, Icon value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Serialize the Icon to a string
    String iconData = _serializeIcon(value);

    // Save the serialized string in SharedPreferences
    await prefs.setString(key, iconData);
  }

// Helper function to serialize Icon into a string
  String _serializeIcon(Icon icon) {
    // Serialize the Icon by storing its iconData and color
    return '${icon.icon?.codePoint},${icon.icon?.fontFamily},${icon.color?.value}';
  }

// Helper function to deserialize the string back to an Icon
  Icon _deserializeIcon(String iconData) {
    // Split the string back into components
    List<String> parts = iconData.split(',');

    // Get the iconData and color
    int codePoint = int.parse(parts[0]);
    String fontFamily = parts[1];
    Color color = Color(int.parse(parts[2]));

    // Create and return the Icon object
    return Icon(IconData(codePoint, fontFamily: fontFamily), color: color);
  }
  // Method to save a list of integers
  Future<void> saveIntList(String key, List<int> values) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values.map((e) => e.toString()).toList());
  }
  //suuprimer
  Future<void> removeFavoriteRecipe(int recipeId) async {
    List<int> favorites = await getIntList('favorite_recipes') ?? [];
    favorites.remove(recipeId); // Supprimer l'ID du favori
    await saveIntList('favorite_recipes', favorites); // Sauvegarder la liste mise à jour
  }
  Future<void> addFavoriteRecipe(int recipeId) async {
    List<int> favoriteRecipes = await getIntList('favorite_recipes') ?? [];
    if (!favoriteRecipes.contains(recipeId)) {
      favoriteRecipes.add(recipeId);
      await saveIntList('favorite_recipes', favoriteRecipes);
    }

  }

  // Method to retrieve a list of integers
  Future<List<int>?> getIntList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(key);

    if (stringList == null) {
      return null;
    }

    // Convert the list of strings back into a list of integers
    return stringList.map((e) => int.parse(e)).toList();
  }

}