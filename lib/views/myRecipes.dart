import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/routes/routesnames.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';

class MyRecipes extends StatelessWidget {
  MyRecipes({super.key});
  final MyRecipesController controller = Get.put(MyRecipesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Recipes')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.recipes.length,
          itemBuilder: (context, index) {
            final recipe = controller.recipes[index];
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
                  : Icon(Icons.fastfood, size: 50), // Icône par défaut
              title: Text(recipe.title),
              subtitle: Text(recipe.cooktime),
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
