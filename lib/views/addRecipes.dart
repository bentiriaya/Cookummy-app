import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:flutter_application_1/data/strings.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_provider.dart';
import '../model/recipe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Pour stocker l'icône sélectionnée

class AddRecipePage extends StatefulWidget {
  final RecipeModel? recipeToEdit; // Paramètre pour passer la recette à modifier

  AddRecipePage({super.key, this.recipeToEdit});

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
  Icon? selectedIcon; // Pour stocker l'icône sélectionnée

  @override
  void initState() {
    super.initState();

    // Si une recette est passée pour modification, on initialise les champs
    if (widget.recipeToEdit != null) {
      titleController.text = widget.recipeToEdit!.title;
      ingredientsController.text = widget.recipeToEdit!.ingredients.join(','); // Conversion en chaîne
      instructionsController.text = widget.recipeToEdit!.instructions;
      cooktimeController.text = widget.recipeToEdit!.cooktime;
      imagePath = widget.recipeToEdit!.imageUrl;
      selectedType = widget.recipeToEdit!.type;
      selectedIcon = Data.recipeTypes2[selectedType!]; // Initialiser l'icône
    }
  }

  // Fonction pour sélectionner une image depuis la galerie
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  // Sauvegarder le type sélectionné dans SharedPreferences
  Future<void> _saveSelectedType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedType', type);
    await prefs.setString('selectedIcon', type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeToEdit == null ? "Ajouter une Recette" : "Modifier la Recette"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sélectionner une image pour la recette
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundColor: color.yellow,
                radius: 50,
                backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
                child: imagePath == null
                    ? (selectedType != null
                    ? Data.recipeTypes2[selectedType!]  // Afficher l'icône sélectionnée
                    : Icon(Icons.camera_alt, size: 40, color: Colors.grey))
                    : null,
              ),
            ),
            SizedBox(height: 20),
            // Champ pour le titre
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Titre"),
            ),
            // Champ pour les ingrédients
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: "Ingrédients (séparés par des virgules)"),
            ),
            // Champ pour les instructions
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(labelText: "Instructions"),
            ),
            // Liste déroulante pour sélectionner le type de recette
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(labelText: "Type de Recette"),
              items: Data.recipeTypes2.keys.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Row(
                    children: [
                      Data.recipeTypes2[type]!, // Afficher l'icône à côté du texte
                      SizedBox(width: 8), // Espacement
                      Text(type),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue;
                  selectedIcon = Data.recipeTypes2[newValue];
                });

                // Sauvegarder le type sélectionné dans SharedPreferences
                if (newValue != null) {
                  _saveSelectedType(newValue);
                }
              },
            ),
            // Champ pour le temps de cuisson
            TextField(
              controller: cooktimeController,
              decoration: InputDecoration(labelText: "Temps de cuisson"),
            ),
            SizedBox(height: 20),
            // Bouton pour ajouter ou modifier la recette
            ElevatedButton(
              onPressed: () async {
                final newRecipe = RecipeModel(
                  id: widget.recipeToEdit?.id ?? 0, // Si c'est une modification, garder l'ID existant
                  title: titleController.text,
                  ingredients: ingredientsController.text.split(','),
                  instructions: instructionsController.text,
                  imageUrl: imagePath ?? '',
                  type: selectedType ?? '', // Utiliser le type sélectionné
                  cooktime: cooktimeController.text,
                );

                final recipeController = Get.find<MyRecipesController>();
                if (widget.recipeToEdit == null) {
                  await recipeController.addRecipe(newRecipe); // Ajouter si c'est une nouvelle recette
                } else {
                  await recipeController.updateRecipe(newRecipe); // Modifier si c'est une recette existante
                }

                Get.back(); // Retourner à la page précédente
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color.yellow,
                foregroundColor: Colors.white,
              ),
              child: Text(widget.recipeToEdit == null ? "Ajouter la Recette" : "Modifier la Recette"),
            ),
          ],
        ),
      ),
    );
  }
}
