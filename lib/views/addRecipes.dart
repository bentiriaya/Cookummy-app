import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_provider.dart';
import '../model/recipe.dart';
import 'package:get/get.dart';

class AddRecipePage extends StatefulWidget {
  AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController cooktimeController = TextEditingController();

  String? imagePath; // Pour stocker le chemin de l'image
  String? selectedType; // Pour stocker le type de recette sélectionné

  // Map des types de recettes avec les icônes
  static const Map<String, Icon> recipeTypes = {
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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path; // Mettre à jour l'état avec le chemin de l'image
      });
      print("Image selected: $imagePath"); // Débogage : imprimer le chemin de l'image
    } else {
      print("No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une Recette"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage, // Appeler la fonction pour sélectionner l'image
              child: CircleAvatar(
                backgroundColor: color.yellow,
                radius: 50, // Taille du cercle
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!)) // Afficher l'image sélectionnée
                    : null, // Pas d'image si aucune sélectionnée
                child: imagePath == null
                    ? (selectedType != null
                    ? recipeTypes[selectedType] // Afficher l'icône du type sélectionné
                    : Icon(Icons.camera_alt, size: 40, color: Colors.grey)) // Icône par défaut si pas d'image
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Titre"),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: "Ingrédients (séparés par des virgules)"),
            ),
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(labelText: "Instructions"),
            ),
            // Menu déroulant pour le type de recette
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(labelText: "Type de Recette"),
              items: recipeTypes.keys.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Row(
                    children: [
                      recipeTypes[type]!, // Afficher l'icône à côté du texte
                      SizedBox(width: 8), // Espacement
                      Text(type),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue; // Mettre à jour le type sélectionné
                });
              },
            ),
            TextField(
              controller: cooktimeController,
              decoration: InputDecoration(labelText: "Temps de cuisson"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newRecipe = RecipeModel(
                  id: 0,
                  title: titleController.text,
                  ingredients: ingredientsController.text.split(','),
                  instructions: instructionsController.text,
                  imageUrl: imagePath ?? '',
                  type: selectedType ?? '', // Utiliser le type sélectionné
                  cooktime: cooktimeController.text,
                );

                // Utiliser le RecipeController pour ajouter la recette
                final recipeController = Get.find<MyRecipesController>();
                await recipeController.addRecipe(newRecipe);

                Get.back(); // Revenir à la page précédente
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color.yellow, // Couleur de fond
                foregroundColor: Colors.white,  // Couleur du texte
              ),
              child: Text("Ajouter la Recette"),
            ),
          ],
        ),
      ),
    );
  }
}
