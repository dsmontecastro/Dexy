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

  // Table Handlers ------------------------------------------------------------

  Future<void> dropTable(String table) async {
    final Database? db = await instance.database;
    await db!.execute("DROP TABLE IF EXISTS $table");
  }

  Future<void> clearTable(String table) async {
    final Database? db = await instance.database;
    await db!.execute("DELETE FROM $table");
  }

  Future<void> makeTable({String table = ""}) async {
    final Database? db = await instance.database;

    if (table == "") {
      _onCreate(db!, await db.getVersion());
    } else {
      db!.execute(Models.makers[table]!);
      addFiller(db, table);
    }
  }

  Future<bool> tableExists(String table) async {
    final Database? db = await instance.database;
    List<dynamic> tables = await db!.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: [table],
    );

    return tables.isNotEmpty;
  }

  Future<void> addFiller(Database db, String table) async {
    int id = await db.update(
      table,
      Models.fillers[table]!,
      where: "id = ?",
      whereArgs: [0],
    );

    if (id == 0) {
      await db.insert(
        table,
        Models.fillers[table]!,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Core Database Methods -----------------------------------------------------

  Future<void> close() async {
    final Database? db = await instance.database;
    db!.close();
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

  Future<int> upsert<M extends Model>(String table, M item) async {
    final M row = await getById<M>(table, item.getId());

    if (row.getId() > 0) {
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

  Future<M> getById<M extends Model>(String table, int id) async {
    final Database? db = await instance.database;

    final query = await db!.query(
      table,
      where: "id = ?",
      whereArgs: [id],
      columns: Models.fields[M],
    );
    if (query.isNotEmpty) {
      return Models.fromDB<M>(query.first);
    } else {
      return Models.filler<M>();
    }
  }

  Future<List<M>> getAll<M extends Model>(String table) async {
    final Database? db = await instance.database;

    final query = await db!.query(
      table,
      where: "id != 0",
      orderBy: "ID ASC",
      columns: Models.fields[M],
    );

    List<M> results = [];

    if (query.isNotEmpty) {
      results = query.map((row) => Models.fromDB<M>(row)).toList();
    }

    return results;
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

    return openDatabase(
      filePath,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async => await db.execute("PRAGMA foreign_keys = ON");

  Future<void> _onCreate(Database db, int version) async {
    Map<String, String> makers = Models.makers;
    List<String> models = makers.keys.toList();

    for (String model in models) {
      db.execute(makers[model]!);
      addFiller(db, model);
    }
  }
}
