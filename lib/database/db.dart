import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'models/_model.dart';
import 'models/pokemon.dart';

class DB {
  //

  // Constants -----------------------------------------------------------------

  static const String dbName = "PokeDB";

  // Instantiation -------------------------------------------------------------

  static final DB instance = DB._init();
  DB._init();

  // Database Property ---------------------------------------------------------

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _init(dbName);
    return _database;
  }

  // Core Database Methods -----------------------------------------------------

  Future close() async {
    final Database? db = await instance.database;
    db!.close();
  }

  Future<bool> tableExists(String table) async {
    final Database? db = await instance.database;
    List<dynamic> tables =
        await db!.query('sqlite_master', where: 'name = ?', whereArgs: [table]);

    return tables.isNotEmpty;
  }

  Future<int> insert<M extends Model>(String table, M item) async {
    final Database? db = await instance.database;
    return await db!.insert(
      table,
      item.toDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update<M extends Model>(String table, M item) async {
    final Database? db = await instance.database;
    return await db!.update(
      table,
      item.toDB(),
      where: "id = ?",
      whereArgs: [item.getId()],
    );
  }

  // Future<int> upsert(String table, Map<String, dynamic> json) async {
  // final int id = await getById(table, json["id"] as int);
  Future<int> upsert<M extends Model>(String table, M item) async {
    final int id = await getById<M>(table, item.getId());
    print(">>> UPSERT@$table: $id");

    if (id > 0) {
      return await update(table, item);
    } else {
      return await insert(table, item);
    }
  }

  Future<int> delete<M extends Model>(String table, M item) async {
    final Database? db = await instance.database;
    return await db!.delete(
      table,
      where: "id = ?",
      whereArgs: [item.getId()],
    );
  }

  Future getById<M extends Model>(String table, int id) async {
    final Database? db = await instance.database;

    final query = await db!.query(
      table,
      where: "id = ?",
      whereArgs: [id],
      columns: Models.fields[M],
    );

    try {
      return Models.fromDB(query.first);
    } catch (err) {
      // throw Exception(err);
      return 0;
    }
  }

  Future<List> getAll<M extends Model>(String table) async {
    final Database? db = await instance.database;

    final query = await db!.query(
      table,
      orderBy: "ID ASC",
      columns: Models.fields[M],
    );

    return query.map((item) => Models.fromDB(query.first)).toList();
  }

  // Favorite/Caught Toggles ---------------------------------------------------

  Future<int> toggleFavorite(Pokemon pokemon) async {
    final Database? db = await instance.database;
    pokemon.favorite = !pokemon.favorite;
    return await db!.update(
      pokemonModel,
      pokemon.toDB(),
      where: "id = ?",
      whereArgs: [pokemon.id],
    );
  }

  Future<int> toggleCaught(Pokemon pokemon) async {
    final Database? db = await instance.database;
    pokemon.caught = !pokemon.caught;

    return await db!.update(
      pokemonModel,
      pokemon.toDB(),
      where: "id = ?",
      whereArgs: [pokemon.id],
    );
  }

  // Configuration & Initialization --------------------------------------------

  Future<Database> _init(String fileName) async {
    final String dbPath = await getDatabasesPath();
    final String filePath = path.join(dbPath + fileName);
    debugPrint("DB@: $filePath");

    return openDatabase(filePath,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future _onConfigure(Database db) async =>
      await db.execute("PRAGMA foreign_keys = ON");

  Future _onCreate(Database db, int version) async {
    // Create TABLEs from Models

    List<String> models = Models.models.keys.toList();

    for (String table in models) {
      await db.execute(table);
    }
  }

  // Debugging -----------------------------------------------------------------

  Future<void> createTable(String table) async {
    final Database? db = await instance.database;
    bool exists = await tableExists(table);
    if (!exists) db!.execute(Models.makers[table]!);
  }

  Future<void> dropTable(String table) async {
    final Database? db = await instance.database;
    await db!.execute("DROP TABLE IF EXISTS $table");
  }
}
