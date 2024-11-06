import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/myRecipesController.dart';
import 'package:flutter_application_1/data/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../db/db_provider.dart';
import '../model/recipe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For saving selected icon

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

  String? imagePath; // For storing the image path
  String? selectedType; // For storing the selected recipe type
  Icon? selectedIcon; // For storing the selected icon

  // Map of recipe types with icons
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
        imagePath = pickedFile.path; // Update the image path state
      });
      print("Image selected: $imagePath"); // Debug: print the image path
    } else {
      print("No image selected.");
    }
  }

  // Save the icon data in SharedPreferences
  Future<void> _saveSelectedType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Serialize icon data: we store the icon name for easy retrieval
    await prefs.setString('selectedType', type);
    // Optionally save the icon if needed (e.g., store its codePoint or name)
    await prefs.setString('selectedIcon', type);
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
              onTap: _pickImage, // Call the function to pick the image
              child: CircleAvatar(
                backgroundColor: color.yellow,
                radius: 50, // Circle size
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!)) // Show the selected image
                    : null, // No image if none selected
                child: imagePath == null
                    ? (selectedType != null
                    ? recipeTypes[selectedType!] // Show the selected type icon
                    : Icon(Icons.camera_alt, size: 40, color: Colors.grey)) // Default icon if no image
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
            // Dropdown to select recipe type
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(labelText: "Type de Recette"),
              items: recipeTypes.keys.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Row(
                    children: [
                      recipeTypes[type]!, // Show the icon next to text
                      SizedBox(width: 8), // Spacing
                      Text(type),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue; // Update the selected type
                  selectedIcon = recipeTypes[newValue]; // Save the corresponding icon
                });

                // Save the selected type and icon to SharedPreferences
                if (newValue != null) {
                  _saveSelectedType(newValue);
                }
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
                  type: selectedType ?? '', // Use the selected type
                  cooktime: cooktimeController.text,
                );

                // Use the RecipeController to add the recipe
                final recipeController = Get.find<MyRecipesController>();
                await recipeController.addRecipe(newRecipe);

                Get.back(); // Go back to the previous page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color.yellow, // Button background color
                foregroundColor: Colors.white,  // Text color
              ),
              child: Text("Ajouter la Recette"),
            ),
          ],
        ),
      ),
    );
  }
}
