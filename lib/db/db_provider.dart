import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/recipe.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database? _database;

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Si la base de données n'existe pas encore, créez-la
    _database = await _initDatabase();
    return _database!;
  }

  // Crée la base de données et la table
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 2, // Mise à jour de la version
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, ingredients TEXT, instructions TEXT, imageUrl TEXT, type TEXT, cooktime TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE recipes ADD COLUMN type TEXT');
          await db.execute('ALTER TABLE recipes ADD COLUMN cooktime TEXT');
        }
      },
    );
  }

  // CRUD Operations
  Future<void> insertRecipe(RecipeModel recipe) async {
    final db = await database;
    // Remove 'id' from the map to let the database auto-increment it
    var recipeData = recipe.toMap();
    recipeData.remove('id');

    await db.insert(
      'recipes',
      recipeData,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }


  Future<List<RecipeModel>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipes');

    return List.generate(maps.length, (i) {
      return RecipeModel.fromMap(maps[i]);
    });
  }


  Future<void> updateRecipe(RecipeModel recipe) async {
    final db = await database;
    await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<void> deleteRecipe(int id) async {
    final db = await database;
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}