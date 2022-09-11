
import 'package:movie_link/models/favorite_sqlite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  var database;
  create()async{
    database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'favorite.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE favorites(id INTEGER PRIMARY KEY)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  }


    // Define a function that inserts dogs into the database
    Future<void> insertFavorite(Favorite favorite) async {
      // Get a reference to the database.
      final db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'favorites',
        favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

// A method that retrieves all the dogs from the dogs table.
  Future<List<Favorite>> favorites() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Favorite(
        id: maps[i]['id'],
      );
    });
  }

  Future<bool> checkFavorite(id) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT id FROM favorites Where id = $id');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return maps.isNotEmpty;
  }

  Future<void> deleteFavorite(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'favorites',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}