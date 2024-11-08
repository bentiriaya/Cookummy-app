import 'package:get/get.dart';
import '../Services/sharedperfsManagers.dart';
import '../data/apisource.dart';

class RecipeDetailController extends GetxController {
  // Déclaration des variables observables
  var id = 0.obs;
  var title = ''.obs;
  var cookTime = ''.obs;
  var thumbnailUrl = ''.obs;
  var instructions = ''.obs;
  var ingredients = <String>[].obs;
  var isFavorite =false.obs;


  // Liste des recettes (cela doit être initialisé ou récupéré d'une source)
  List<Map<String, dynamic>> recs = recipes;

  // Fonction pour inverser l'état de favori
  void toggleFavoriteStatus(int recipeId) async {
    isFavorite.value = !isFavorite.value;

    // Chercher la recette par son ID et changer son statut
    for (var recipe in recs) {
      if (recipe['id'] == recipeId) {
        // Inverse la valeur de 'isFavorite'
        bool currentStatus = recipe['isFavorite'] ?? false;  // Récupère l'état actuel, ou false si non défini
        recipe['isFavorite'] = !currentStatus;  // Change la valeur (si true, devient false, et vice versa)

        // Sauvegarde dans SharedPreferences
        SharedperfManager sharedPerfManager = Get.put(SharedperfManager());

        // Enregistre la valeur inversée de 'isFavorite'
        await sharedPerfManager.saveBool('isFavorite_${recipeId}', recipe['isFavorite']);

        break;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    final SharedperfManager sp = Get.find<SharedperfManager>();

    // Charge les recettes et leurs statuts de favoris depuis SharedPreferences


    // Attendre que toutes les données soient chargées avant d'assigner les valeurs
    id.value = await sp.getInt("id") ?? 0;
    title.value = await sp.getString("title") ?? "No Title";
    cookTime.value = await sp.getString("cooktime") ?? "N/A";
    thumbnailUrl.value = await sp.getString("imageUrl") ?? "";
    instructions.value = await sp.getString("instructions") ?? "No instructions";
    ingredients.value = await sp.getStringList("ingredients") ?? ["No ingredients"];
    isFavorite.value=await sp.getBool('isFavorite_$id')?? false ;
  }
}
