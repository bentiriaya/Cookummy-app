import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:flutter_application_1/views/addRecipes.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/sharedperfsManagers.dart';
import '../data/strings.dart';
import '../model/recipe.dart';


class MyRecipes extends StatelessWidget {
  MyRecipes({super.key});
  final SharedperfManager sp = Get.put(SharedperfManager());
  final MyRecipesController controller = Get.put(MyRecipesController());
  Future<Icon> _getIconForType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iconString = prefs.getString('selectedIcon');
    // Retourne l'icône par défaut si aucune icône n'est enregistrée
    return Data.recipeTypes2[type] ?? Icon(Icons.fastfood, size: 50);
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, int recipeId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this recipe?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await controller.deleteRecipe(recipeId); // Supprimer la recette
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Data.myrecipes),automaticallyImplyLeading: false,),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.recipes.length,
          itemBuilder: (context, index) {
            final recipe = controller.recipes[index];
            return FutureBuilder<Icon>(
              future: _getIconForType(recipe.type), // Récupérer l'icône associée au type
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text(recipe.title),
                    subtitle: Text(recipe.cooktime),
                  );
                }

                // Utiliser l'icône récupérée
                Icon icon = snapshot.data ?? Icon(Icons.fastfood, size: 50);

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
                        ? ClipOval(
                      child: Image.file(
                       File(recipe.imageUrl!)  ,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                        : icon, // Utiliser l'icône obtenue si aucune image
                    title: Text(
                      recipe.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      recipe.cooktime,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: color.yellow),
                      onPressed: () {
                        // Passer la recette à modifier
                        Get.to(AddRecipePage(recipeToEdit: recipe));
                      },
                    ),
                    onTap: () async {
                      final rec = RecipeModel(
                        id: recipe.id,
                        title: recipe.title,
                        ingredients: recipe.ingredients,
                        instructions: recipe.instructions,
                        imageUrl: recipe.imageUrl,
                        type: recipe.type,
                        cooktime: recipe.cooktime,
                      ).toMap();
                      controller.gotoDetails(rec);
                      //  await sp.saveInt("id", recipe["id"]);
                      print('${recipe.id}recipe.id');
                      await sp.saveInt("id", recipe.id);
                      await sp.saveString("title",recipe.title);
                      await sp.saveString("instructions", recipe.instructions);
                      await sp.saveStringList("ingredients", recipe.ingredients);
                      await sp.saveString("imageUrl", recipe.imageUrl);
                      await sp.saveString("cooktime", recipe.cooktime);
                      // Passez les détails de la recette vers la page RecipeDetailsPage
                      Get.toNamed(
                        namesRoute.myrecDet,


                      );
                    },
                    onLongPress: () {
                      // Afficher la boîte de dialogue de confirmation de suppression
                      _showDeleteConfirmationDialog(context, recipe.id);
                    },
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(namesRoute.addRec);
        },
        backgroundColor: color.yellow,
        foregroundColor: Colors.white,
        elevation: 6,
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
