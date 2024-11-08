import 'package:get/get.dart';
import '../Services/sharedperfsManagers.dart';

class RecipeDetailController extends GetxController {
  // Déclaration des variables observables
  var id = 0.obs;
  var title = ''.obs;
  var cookTime = ''.obs;
  var thumbnailUrl = ''.obs;
  var instructions = ''.obs;
  var ingredients = <String>[].obs;


  @override
  void onInit() async {
    super.onInit();
    final SharedperfManager sp = Get.find<SharedperfManager>();

    // Attendre que toutes les données soient chargées avant d'assigner les valeurs
    id.value = await sp.getInt("id") ?? 0;
    title.value = await sp.getString("title") ?? "No Title";
    cookTime.value = await sp.getString("cooktime") ?? "N/A";
    thumbnailUrl.value = await sp.getString("imageUrl") ?? "";
    instructions.value = await sp.getString("instructions") ?? "No instructions";
    ingredients.value = await sp.getStringList("ingredients") ?? ["No ingredients"];
  }
}
