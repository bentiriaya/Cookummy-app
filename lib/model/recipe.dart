class RecipeModel {
  int id;
  String title;
  List<String> ingredients;
  String instructions;
  String imageUrl;
  String type;
  String cooktime;


  RecipeModel({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
    required this.type,
    required this.cooktime,
  });

  // Convert RecipeModel to a map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients.join(','), // Convert list to a string
      'instructions': instructions,
      'imageUrl': imageUrl,
      'type': type, // Include type in map
      'cooktime': cooktime,
    };
  }

  // Create RecipeModel from a map for reading from the database
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'],
      title: map['title'],
      ingredients: (map['ingredients'] as String).split(','), // Convert string back to list
      instructions: map['instructions'],
      imageUrl: map['imageUrl'],
      type: map['type'], // Retrieve type from map
      cooktime: map['cooktime'],
    );
  }
}

