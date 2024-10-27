import 'package:flutter_application_1/model/recipe.dart';
import 'package:get/get.dart';
import '../data/strings.dart';

import 'ourRecipesController.dart'; // Import your Data class that contains recipe data

class TypeCardController extends GetxController {
  final OurRecipesController recipesController = Get.put(OurRecipesController());
  var selectedType = 'tout'.obs; // Observable pour le type sélectionné

// Méthode pour définir le type sélectionné
  void selectType(String type) {
    selectedType.value = type; // Met à jour le type sélectionné
  }
  // Vérifie si le type donné est sélectionné
  bool isTypeSelected(String type) {
    return selectedType.value == type;
  }

  // Méthode pour filtrer les recettes en fonction du type sélectionné
  List<Map<String, dynamic>> getFilteredRecipes() {
    if (selectedType.value == 'tout') {
      return recipesController.getAllRecipes();
    } else {
      return recipesController.getRecipesByType(selectedType.value);
    }
  }
}
