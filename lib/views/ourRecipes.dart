import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Cookummy/routes/routesnames.dart';

import 'package:Cookummy/views/widgets/recipe_card.dart';
import 'package:Cookummy/views/widgets/type_card.dart';


import 'package:get/get.dart';

import '../Controllers/ourRecipesController.dart';
import '../Controllers/typecArdController.dart';
import '../Services/sharedperfsManagers.dart';
import '../data/strings.dart';


class ourRecipes extends StatelessWidget {
 //appel des controllers
  final OurRecipesController recipesController = Get.put(OurRecipesController());
  final TypeCardController typeCardController = Get.put(TypeCardController());
  final SharedperfManager sp=Get.put(SharedperfManager());

  int selectedCardIndex = 0;

  // Define cards as a late variable
 // late List<TypeCard> cards=Data.getRecipeTypes(selectedCardIndex);



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title: Text(Data.accueil),automaticallyImplyLeading: false, ),
      body: Column(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Data.recipeTypes.length,
              itemBuilder: (context, index) {
                String type = Data.recipeTypes.keys.elementAt(index);
                Icon icon = Data.recipeTypes.values.elementAt(index);
                return TypeCard(title: type, icon: icon);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              final filteredRecipes = typeCardController.getFilteredRecipes();
              return ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  return GestureDetector(
                    onTap: () async{
                      // Navigation vers la page de détails avec les données de la recette
                      recipesController.goToRecipeDetails(recipe);
                      await sp.saveInt("id", recipe["id"]);
                      await sp.saveString("title",recipe["title"]);
                      await sp.saveString("instructions", recipe["instructions"]);
                      await sp.saveStringList("ingredients", recipe["ingredients"]);
                      await sp.saveString("imageUrl", recipe["imageUrl"]);
                      await sp.saveString("cooktime", recipe["cooktime"]);

                      // Récupération et affichage de la valeur sauvegardée
                      String? savedTitle = await sp.getString("title");
                      String? savedInstruction = await sp.getString("instructions");
                      String? savedImage=await sp.getString("imageUrl");
                      String? savedCookTime=await sp.getString("cooktime");
                      List<String>? savedList=await sp.getStringList("ingredients");
                      int? savedId=await sp.getInt("id");
                      print(savedImage); // Cela va afficher le titre sauvegardé

                    },
                    child: RecipeCard(

                      title: recipe["title"],
                      cookTime: recipe["cooktime"],
                      thumbnailUrl: recipe["imageUrl"],
                    ),
                  );
                },
              );
            }),
          ),

        ],
      ),
    );
  }
}
