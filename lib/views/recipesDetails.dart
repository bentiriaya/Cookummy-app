import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/RecipeDetailController.dart';
import '../Services/sharedperfsManagers.dart';

class RecipeDetailsPage extends StatelessWidget {
  final RecipeDetailController controller = Get.put(RecipeDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Obx(() => controller.thumbnailUrl.value.isNotEmpty
                    ? Image.asset(
                  controller.thumbnailUrl.value,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                )
                    : SizedBox.shrink()),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.black),
                        onPressed: () {
                          // Ajoutez ici la logique pour marquer la recette en favoris
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.black),
                        onPressed: () {
                          // Ajoutez ici la logique pour partager la recette
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => Text(
                controller.title.value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Obx(() => Text(
                'Cook Time: ${controller.cookTime.value}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ingredients',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.ingredients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    controller.ingredients[index],
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => Text(
                controller.instructions.value,
                style: TextStyle(fontSize: 16),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
