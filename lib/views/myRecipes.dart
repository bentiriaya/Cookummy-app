import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/data/strings.dart';
import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/sharedperfsManagers.dart';
import '../model/recipe.dart';

class MyRecipes extends StatelessWidget {
  MyRecipes({super.key});
  final SharedperfManager sp=Get.put(SharedperfManager());
  final MyRecipesController controller = Get.put(MyRecipesController());

  Future<Icon> _getIconForType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iconString = prefs.getString('selectedIcon');

    // Si on n'a pas d'icône enregistrée, retourner une icône par défaut
    if (iconString == null) {
      return Icon(Icons.fastfood, size: 50);
    }



    return Data.recipeTypes2[type] ?? Icon(Icons.fastfood, size: 50); // Icône par défaut si type inconnu
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

                  onTap: () async{
                   final rec=RecipeModel(id:recipe.id,title:recipe.title,ingredients:recipe.ingredients,instructions:recipe.instructions,imageUrl:recipe.imageUrl,type:recipe.type,cooktime:recipe.cooktime).toMap();
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
                      namesRoute.detailRec,


                    );
                  },
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
