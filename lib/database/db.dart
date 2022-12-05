import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'models/_model.dart';
import 'models/abilities.dart';
import 'models/pokemon.dart';
import 'models/species.dart';
// import 'models/sprites.dart';
import 'models/target.dart';
import 'models/moves.dart';

class Types {
  static const pKeyType = "INTEGER PRIMARY KEY NOT NULL";
  static const boolType = "BOOLEAN NOT NULL";
  static const textType = "TEXT NOT NULL";
  static const intType = "INTEGER NOT NULL";
  static const nIullntType = "INTEGER";
}

const Map<String, Type> models = {
  abilityModel: Ability,
  pokemonModel: Pokemon,
  speciesModel: Species,
  // spriteModel: Sprite,
  targetModel: Target,
  moveModel: Move,
};

class DB {
  //----------------------------------------------------------------------------

  // Constants
  static const String dbName = "PokeDB";

  // Instantiation
  static final DB instance = DB._init();
  DB._init();

  //----------------------------------------------------------------------------

  // Database Property
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _init(dbName);
    return _database;
  }

  //----------------------------------------------------------------------------

  // Core Database Methods

  Future close() async {
    final Database? db = await instance.database;
    db!.close();
  }

  Future<int> insert(String tableName, Model item) async {
    final Database? db = await instance.database;
    return await db!.insert(
      tableName,
      item.toDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(String tableName, Model item) async {
    final Database? db = await instance.database;
    return await db!.update(
      tableName,
      item.toDB(),
      where: "id = ?",
      whereArgs: [item.getId()],
    );
  }

  Future<int> upsert(String tablename, Model item) async {
    // final Database? db = await instance.database;
    final int id = await getById(tablename, item.getId());

    if (id >= 0) {
      return await update(tablename, item);
    } else {
      return await insert(tablename, item);
    }
  }

  Future getById(String tableName, int id) async {
    final Database? db = await instance.database;
    final Model table = models[tableName] as Model;

    final query = await db!.query(
      tableName,
      columns: table.getFields(),
      where: "id = ?",
      whereArgs: [id],
    );

    try {
      return table.fromDB(query.first);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List> getAll(String tableName) async {
    final Database? db = await instance.database;
    final Model table = models[tableName] as Model;
    final fields = table.getFields();

    final query = await db!.query(tableName, columns: fields, orderBy: "ID ASC");
    return query.map((item) => table.fromDB(item)).toList();
  }

  //----------------------------------------------------------------------------

  // Initialization
  Future<Database> _init(String fileName) async {
    final String dbPath = await getDatabasesPath();
    final String filePath = path.join(dbPath + fileName);
    debugPrint(filePath);

    return openDatabase(filePath, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future _onConfigure(Database db) async => await db.execute("PRAGMA foreign_keys = ON");

  Future _onCreate(Database db, int version) async {
    // Pokemon Model
    await db.execute("""
    CREATE TABLE
    """);
  }
}
