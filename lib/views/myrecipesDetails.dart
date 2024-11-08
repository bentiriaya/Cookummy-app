
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../Controllers/RecipeDetailController.dart';
import 'package:path/path.dart' as path;
import '../Services/sharedperfsManagers.dart';

class MyRecipeDetailsPage extends StatelessWidget {
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

                    ? Image.file(
                File(controller.thumbnailUrl.value)  ,
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
                        icon: Icon(Icons.share, color: Colors.black),
                        onPressed: () async{
                          // Contenu à partager
                          String shareContent = 'Check out this recipe: ${controller.title.value}\n'
                              'Cook Time: ${controller.cookTime.value}\n'
                              'Ingredients: ${controller.ingredients.join(", ")}\n'
                              'Instructions: ${controller.instructions.value}\n'
                              'For more, visit: [Add your URL here]';

                          // Vérifiez si le fichier image existe avant de partager
                          // final imagePath = controller.thumbnailUrl.value;
                          // final imageFile = File(imagePath);
await Share.share(shareContent);
                          // if (await imageFile.exists()) {
                          //   // Partagez le fichier image et le texte
                          //   final xFile = XFile(imagePath);
                          //   await Share.shareXFiles([xFile], text: shareContent);
                          // } else {
                          //   // Message d'erreur si l'image n'existe pas
                          //   Get.snackbar("Error", "Image not found for sharing.",
                          //       snackPosition: SnackPosition.BOTTOM);
                          // }

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
