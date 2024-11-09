import 'package:flutter/material.dart';
import 'package:Cookummy/data/apisource.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Services/sharedperfsManagers.dart';
import '../Controllers/RecipeDetailController.dart';
import '../data/strings.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    // Afficher le dialog à l'ouverture de la page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInfoDialog(context);
    });

    return Scaffold(
      appBar: AppBar(title: Text(Data.favoris), automaticallyImplyLeading: false),
      body: FutureBuilder<List<int>>(
        future: _getFavoriteRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite recipes.'));
          } else {
            List<int> favoriteIds = snapshot.data!;

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: _getRecipesByIds(favoriteIds),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> favoriteRecipes = snapshot.data!;

                  return Center(
                    child: CarouselSlider.builder(
                      itemCount: favoriteRecipes.length,
                      itemBuilder: (context, index, realIndex) {
                        var recipe = favoriteRecipes[index];
                        return GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (details.primaryDelta! < 0) { // Détection d'un glissement vers le haut
                              _removeFavoriteRecipe(recipe['id']);
                            }
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.blueAccent.shade100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    recipe['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          recipe['title'],
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 10.0,
                                                color: Colors.black.withOpacity(0.6),
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Cook Time: ${recipe['cooktime']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<List<int>> _getFavoriteRecipes() async {
    SharedperfManager sharedPerfManager = Get.find<SharedperfManager>();
    return await sharedPerfManager.getIntList('favorite_recipes') ?? [];
  }

  Future<List<Map<String, dynamic>>> _getRecipesByIds(List<int> ids) async {
    List<Map<String, dynamic>> recs = recipes;
    return recs.where((recipe) => ids.contains(recipe['id'])).toList();
  }

  void _removeFavoriteRecipe(int recipeId) async {
    SharedperfManager sharedPerfManager = Get.find<SharedperfManager>();
    await sharedPerfManager.removeFavoriteRecipe(recipeId);
    Get.forceAppUpdate();
  }

  // Fonction pour afficher le Dialog
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('Pour supprimer une recette des favoris, faites glisser la carte de la recette vers le haut.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("D'accord"),
            ),
          ],
        );
      },
    );
  }
}
