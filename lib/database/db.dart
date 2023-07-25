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

  Future<int> insert<M extends Model>(String tableName, M item) async {
    final Database? db = await instance.database;
    return await db!.insert(
      tableName,
      item.toDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update<M extends Model>(String tableName, M item) async {
    final Database? db = await instance.database;
    return await db!.update(
      tableName,
      item.toDB(),
      where: "id = ?",
      whereArgs: [item.getId()],
    );
  }

  // Future<int> upsert(String tablename, Map<String, dynamic> json) async {
  // final int id = await getById(tablename, json["id"] as int);
  Future<int> upsert<M extends Model>(String tablename, M item) async {
    final int id = await getById<M>(tablename, item.getId());

    if (id >= 0) {
      return await update(tablename, item);
    } else {
      return await insert(tablename, item);
    }
  }

  Future<int> delete<M extends Model>(String tableName, M item) async {
    final Database? db = await instance.database;
    return await db!.delete(
      tableName,
      where: "id = ?",
      whereArgs: [item.getId()],
    );
  }

  Future getById<M extends Model>(String tableName, int id) async {
    final Database? db = await instance.database;

    final query = await db!.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
      columns: Models.fields[M],
    );

    try {
      return Models.fromDB(query.first);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List> getAll<M extends Model>(String tableName) async {
    final Database? db = await instance.database;

    final query = await db!.query(
      tableName,
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
        onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future _onConfigure(Database db) async =>
      await db.execute("PRAGMA foreign_keys = ON");

  Future _onCreate(Database db, int version) async {
    // Create TABLEs from Models
    for (String maker in Models.makers) {
      await db.execute(maker);
    }
  }
}
