import 'package:path/path.dart' as path;
import 'package:pokedex/database/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';

import 'models/_model.dart';

class Types {
  static const pKeyType = "INTEGER PRIMARY KEY NOT NULL";
  static const boolType = "BOOLEAN NOT NULL";
  static const textType = "TEXT NOT NULL";
  static const intType = "INTEGER NOT NULL";
  static const nIullntType = "INTEGER";
}

const Map<String, Type> tables = {
  pokemonTable: Pokemon,
};

class PokedexDB {
  //----------------------------------------------------------------------------

  // Constants
  static const String dbName = "PokeDB";

  // Instantiation
  static final PokedexDB instance = PokedexDB._init();
  PokedexDB._init();

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

  Future<int> add(String tableName, item) async {
    final Database? db = await instance.database;
    return await db!.insert(
      tableName,
      (item as Table).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future get(String tableName, int id) async {
    final Database? db = await instance.database;
    final Table table = tables[tableName] as Table;

    final query = await db!.query(
      tableName,
      columns: table.getFields(),
      where: "ID = ?",
      whereArgs: [id],
    );

    try {
      return table.fromJson(query.first);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List> all(String tableName) async {
    final Database? db = await instance.database;
    final Table table = tables[tableName] as Table;
    final fields = table.getFields();

    final query = await db!.query(tableName, columns: fields, orderBy: "ID ASC");
    return query.map((item) => table.fromJson(item)).toList();
  }

  //----------------------------------------------------------------------------

  // Initialization
  Future<Database> _init(String fileName) async {
    final String dbPath = await getDatabasesPath();
    final String filePath = path.join(dbPath + fileName);

    return openDatabase(filePath, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future _onConfigure(Database db) async => await db.execute("PRAGMA foreign_keys = ON");

  Future _onCreate(Database db, int version) async {
    // Pokemon Table
    await db.execute("""
    CREATE TABLE
    """);
  }
}
