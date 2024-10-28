import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get.dart';
import '../Services/sharedperfsManagers.dart';
import '../data/apisource.dart';
import '../data/strings.dart';
import '../model/recipe.dart';
import '../views/widgets/type_card.dart'; // Assure-toi que cette importation est correcte

class OurRecipesController extends GetxController {
  // Liste des recettes
  final Recipes = recipes.obs;

  // Liste des types de recettes et icônes associées
  final recipeTypes = Data.recipeTypes.obs;

  // Type de recette actuellement sélectionné
  final selectedType = 'tout'.obs;



  List<Map<String, dynamic>> getAllRecipes() {
    return recipes;
  }

  // Méthode pour obtenir une recette par ID
  Map<String, dynamic>? getRecipeById(int id) {
    return recipes.firstWhereOrNull((recipe) => recipe['id'] == id);
  }
  //methode pour filtrer les recipes par type
  List<Map<String, dynamic>> getRecipesByType(String type) {
    return recipes.where((rec) => rec["type"] == type).toList();
  }

  // Modifier le type sélectionné
  void selectType(String type) {
    selectedType.value = type;
  }
  void goToRecipeDetails(Map<String, dynamic> recipe) async{
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
