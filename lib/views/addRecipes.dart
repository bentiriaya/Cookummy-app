import 'dart:io';

import 'package:flutter/material.dart';
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
  final TextEditingController typeController = TextEditingController();
  final TextEditingController cooktimeController = TextEditingController();

  String? imagePath; // Pour stocker le chemin de l'image

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
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.grey) // Icône si pas d'image
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
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: "Type de recette"),
            ),
            TextField(
              controller: cooktimeController,
              decoration: InputDecoration(labelText: "Temps de cuisson"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Créer un nouvel objet RecipeModel
                final newRecipe = RecipeModel(
                  id: 0,
                  title: titleController.text,
                  ingredients: ingredientsController.text.split(','),
                  instructions: instructionsController.text,
                  imageUrl: imagePath ?? '',
                  type: typeController.text,
                  cooktime: cooktimeController.text,
                );

                // Insérer la recette dans la base de données
                await DatabaseProvider().insertRecipe(newRecipe);

                // Retourner à la page précédente après l'ajout
                Get.back();
              },
              child: Text("Ajouter la Recette"),
            ),
          ],
        ),
      ),
    );
  }
}
