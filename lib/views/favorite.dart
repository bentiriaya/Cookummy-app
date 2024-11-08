import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/apisource.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importez le package carousel_slider
import '../Services/sharedperfsManagers.dart';
import '../Controllers/RecipeDetailController.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
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

                return Center( // Centre le swiper dans la page
                  child: CarouselSlider.builder(
                    itemCount: favoriteRecipes.length,
                    itemBuilder: (context, index, realIndex) {
                      var recipe = favoriteRecipes[index];
                      return Dismissible(
                        key: Key(recipe['id'].toString()), // Utilisation d'un key unique pour chaque recette
                        direction: DismissDirection.endToStart, // Geste de glissement de droite à gauche
                        onDismissed: (direction) async {
                          // Supprimer la recette des favoris
                          SharedperfManager sharedPerfManager = Get.find<SharedperfManager>();
                          await sharedPerfManager.removeFavoriteRecipe(recipe['id']);

                          // Rafraîchir la vue après la suppression
                          Get.forceAppUpdate(); // Cette méthode force la mise à jour de la vue
                        },
                        background: Container(
                          color: Colors.red, // Couleur de fond pendant le glissement
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                          elevation: 15, // Ombre plus forte pour un effet de profondeur
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Bords arrondis
                          ),
                          color: Colors.blueAccent.shade100, // Couleur de fond attrayante
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Image en arrière-plan
                                Image.asset(
                                  recipe['imageUrl'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                // Titre et détails sur le dessus de l'image
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
                                        'Cook Time: ${recipe['cookTime']}',
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
                      height: 400, // Ajustez la hauteur du swiper
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8, // Ajuste l'espace entre les cartes
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<List<int>> _getFavoriteRecipes() async {
    SharedperfManager sharedPerfManager = Get.find<SharedperfManager>();
    return await sharedPerfManager.getIntList('favorite_recipes') ?? [];
  }

  Future<List<Map<String, dynamic>>> _getRecipesByIds(List<int> ids) async {
    // Supposons que "recipes" est une liste préexistante contenant toutes les recettes
    List<Map<String, dynamic>> recs = recipes; // Remplacer par la logique réelle de récupération des recettes
    return recs.where((recipe) => ids.contains(recipe['id'])).toList();
  }
}
