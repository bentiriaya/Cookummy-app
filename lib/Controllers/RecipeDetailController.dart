import 'package:get/get.dart';

class RecipeDetailController extends GetxController{
  late final int id;
  late final String title;
  late final String cookTime;
  late final String thumbnailUrl;
  late final String instructions;
  late final List<String> ingredients;

  @override
  void onInit() {
    // Récupération des arguments au moment de l'initialisation du controller
    final args = Get.arguments as Map<dynamic, dynamic>;
    id = args['id'];
    title = args['title'];
    cookTime = args['cookTime'];
    thumbnailUrl = args['thumbnailUrl'];
    instructions = args['instructions'];
    ingredients = List<String>.from(args['ingredients']); // Convertir les ingrédients en liste
    super.onInit();
  }
}