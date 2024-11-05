import 'package:get/get.dart';
import 'package:flutter_application_1/db/db_provider.dart';


import '../model/recipe.dart';

class MyRecipesController extends GetxController {
  var recipes = <RecipeModel>[].obs; // Reactive list of recipes
  final DatabaseProvider _dbProvider = DatabaseProvider(); // Create an instance of DatabaseProvider

  @override
  void onInit() {
    super.onInit();
    loadRecipes(); // Load all recipes on initialization
  }

  // Function to load all recipes from the database
  Future<void> loadRecipes() async {
    recipes.value = await _dbProvider.getRecipes();
  }

  // Function to add a recipe and refresh the list
  Future<void> addRecipe(RecipeModel recipe) async {
    await _dbProvider.insertRecipe(recipe);
    await loadRecipes(); // This will refresh the list of recipes
  }
}
