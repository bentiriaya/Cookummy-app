import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/RecipeDetailController.dart';


class RecipeDetailsPage extends StatelessWidget {
  final RecipeDetailController controller = Get.put(RecipeDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              controller.thumbnailUrl,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                controller.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Cook Time: ${controller.cookTime}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ingredients',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // ListView for ingredients
            Container(
              height: 150, // Set a fixed height for the ListView
              child: ListView.builder(
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                controller.instructions,
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Ajouter les icônes de favori et de partage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border), // Icône de favori
                  onPressed: () {
                    // Logique pour ajouter aux favoris
                    Get.snackbar("Favori", "${controller.title} a été ajouté aux favoris.");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share), // Icône de partage
                  onPressed: () {

                  },
                ),
              ],
            ),
            SizedBox(height: 20), // Ajouter un espace en bas
          ],
        ),
      ),
    );
  }
}
