import 'package:get/get.dart';
import '../Services/sharedperfsManagers.dart';
import '../data/apisource.dart';

class RecipeDetailController extends GetxController {
  var id = 0.obs;
  var title = ''.obs;
  var cookTime = ''.obs;
  var thumbnailUrl = ''.obs;
  var instructions = ''.obs;
  var ingredients = <String>[].obs;
  var isFavorite = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final SharedperfManager sp = Get.find<SharedperfManager>();

    id.value = await sp.getInt("id") ?? 0;
    title.value = await sp.getString("title") ?? "No Title";
    cookTime.value = await sp.getString("cooktime") ?? "N/A";
    thumbnailUrl.value = await sp.getString("imageUrl") ?? "";
    instructions.value = await sp.getString("instructions") ?? "No instructions";
    ingredients.value = await sp.getStringList("ingredients") ?? ["No ingredients"];
    isFavorite.value = await sp.getBool("isFavorite") ?? false; // Nouvelle ligne
  }

  void toggleFavorite() async {
    isFavorite.value = !isFavorite.value;

    // Mettez à jour la valeur `isFavorite` dans SharedPreferences ou tout autre stockage
    final SharedperfManager sp = Get.find<SharedperfManager>();
    await sp.saveBool("isFavorite", isFavorite.value);

    // Optionnel : mettez à jour la valeur dans votre liste `recipes`
    var recipe = recipes.firstWhere((r) => r['id'] == id.value);
    if (recipe != null) {
      recipe['isFavorite'] = isFavorite.value;
    }
  }
}
