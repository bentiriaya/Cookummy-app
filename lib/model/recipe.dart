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

  // Method to convert RecipeModel to a map (useful for database storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients.join(','), // Convert list to a string
      'instructions': instructions,
      'imageUrl': imageUrl,
      "cooktime":cooktime,
    };
  }

  // Method to create RecipeModel from a map (useful for reading from a database)
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      id: map['id'],
      title: map['title'],
      ingredients: (map['ingredients'] as String).split(','), // Convert string back to list
      instructions: map['instructions'],
      imageUrl: map['imageUrl'], type: '',
      cooktime: map['cooktime']
    );
  }
}
