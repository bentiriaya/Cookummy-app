import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/db/db_provider.dart';


import '../Services/sharedperfsManagers.dart';
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
  Future<void> deleteRecipe(int id) async {
    await _dbProvider.deleteRecipe(id);
    await loadRecipes(); // Recharger la liste après la suppression
  }
  // Mettre à jour une recette
  Future<void> updateRecipe(RecipeModel recipe) async {
    final dbProvider = DatabaseProvider();
    await dbProvider.updateRecipe(recipe); // Mise à jour dans la base de données
    loadRecipes(); // Recharger les recettes après la mise à jour
  }
  Future<void> gotoDetails(Map<String , dynamic> recipe)async {
    final SharedperfManager sp = Get.find<SharedperfManager>();
    await sp.saveInt("id", recipe["id"]);
    await sp.saveString("title", recipe["title"]);
    await sp.saveString("instructions", recipe["instructions"]);
    await sp.saveStringList("ingredients", recipe["ingredients"]);
    await sp.saveString("imageUrl", recipe["imageUrl"]);
    await sp.saveString("cooktime", recipe["cooktime"]);
    Get.toNamed(
      namesRoute.detailRec,
      arguments: {
        'id': recipe['id'],
        'title': recipe['title'],
        'cookTime': recipe['cooktime'],
        'thumbnailUrl': recipe['imageUrl'],
        'ingredients':recipe['ingredients'],
        'instructions':recipe['instructions']
      },
    );
  }
}
