import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/routesnames.dart';

import 'package:flutter_application_1/views/widgets/recipe_card.dart';
import 'package:flutter_application_1/views/widgets/type_card.dart';


import 'package:get/get.dart';

import '../Controllers/ourRecipesController.dart';
import '../Controllers/typecArdController.dart';
import '../data/strings.dart';


class ourRecipes extends StatelessWidget {
 //appel des controllers
  final OurRecipesController recipesController = Get.put(OurRecipesController());
  final TypeCardController typeCardController = Get.put(TypeCardController());

  int selectedCardIndex = 0;

  // Define cards as a late variable
 // late List<TypeCard> cards=Data.getRecipeTypes(selectedCardIndex);



  @override
  Widget build(BuildContext context) {
    return  Column(
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
                  onTap: () {
                    // Navigation vers la page de détails avec les données de la recette
                    recipesController.goToRecipeDetails(recipe);
                   
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
    );
  }
}
