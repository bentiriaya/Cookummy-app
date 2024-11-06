import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRecipes extends StatelessWidget {
  MyRecipes({super.key});
  final MyRecipesController controller = Get.put(MyRecipesController());

  Future<Icon> _getIconForType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iconString = prefs.getString('selectedIcon');

    // Si on n'a pas d'icône enregistrée, retourner une icône par défaut
    if (iconString == null) {
      return Icon(Icons.fastfood, size: 50);
    }

    // Vérifier quel type d'icône est enregistré et renvoyer l'icône correspondante
    Map<String, Icon> recipeTypes = {
      'Tout': Icon(Icons.all_inbox),
      'Salade': Icon(Icons.local_dining),
      'Cake': Icon(Icons.cake),
      'Biscuits': Icon(Icons.cookie),
      'Boulangerie': Icon(Icons.bakery_dining),
      'Boissons': Icon(Icons.local_bar),
      'Fast Food': Icon(Icons.fastfood),
      'Soupe': Icon(Icons.soup_kitchen),
      'Glace': Icon(Icons.icecream),
    };

    return recipeTypes[type] ?? Icon(Icons.fastfood, size: 50); // Icône par défaut si type inconnu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Recipes')),
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

                return ListTile(
                  leading: recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
                      ? ClipOval(
                    child: Image.asset(
                      recipe.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                      : icon, // Utiliser l'icône obtenue
                  title: Text(recipe.title),
                  subtitle: Text(recipe.cooktime),
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
