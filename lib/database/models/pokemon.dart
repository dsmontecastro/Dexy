import 'dart:convert';

import '_model.dart';
import 'ability.dart';
import 'species.dart';

import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/types/classes/stats.dart';

const String pokemonModel = "pokemon";

class Pokemon implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  // Non-Integers
  final String name;
  final bool isDefault;

  // Integers
  final int id;
  final int order;
  final int height;
  final int weight;
  final int baseXP;
  final Typing type1;
  final Typing type2;

  // Foreign Keys
  final int ability1;
  final int ability2;
  final int abilityH;
  final int species;

  // Lists of Foreign Keys
  final List<int> heldItems; // Item Table
  final List<Map<String, dynamic>> moves; // Move Table

  // Stat Modifiers
  final Stats evs;
  final Stats baseStats;

  //----------------------------------------------------------------------------

  // Core Constructor
  Pokemon(
      {required this.name,
      required this.isDefault,
      required this.id,
      required this.order,
      required this.height,
      required this.weight,
      required this.baseXP,
      required this.type1,
      required this.type2,
      required this.ability1,
      required this.ability2,
      required this.abilityH,
      required this.species,
      required this.moves,
      required this.heldItems,
      required this.evs,
      required this.baseStats});

  // Filler Constructor
  Pokemon.filler()
      : name = blank,
        isDefault = false,
        id = 0,
        order = 0,
        height = 0,
        weight = 0,
        baseXP = 0,
        type1 = Typing.error,
        type2 = Typing.error,
        ability1 = 0,
        ability2 = 0,
        abilityH = 0,
        species = 0,
        heldItems = [],
        moves = [],
        evs = Stats.blank(),
        baseStats = Stats.blank();

  // JSON Parsing
  @override
  Pokemon.fromAPI(Map<String, dynamic> json)
      : name = json[PokemonFields.name],
        isDefault = json[PokemonFields.isDefault],
        id = json[PokemonFields.id],
        order = json["order"], // problematic string in DB
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP] ?? 0, // Nullable in later Gens
        type1 = _getType(json, 1),
        type2 = _getType(json, 2),
        ability1 = _getAbility(json, 1),
        ability2 = _getAbility(json, 2),
        abilityH = _getAbility(json, 3),
        species = _getSpecies(json),
        heldItems = _getHeldItems(json),
        moves = _getMoves(json),
        evs = _getStats(json, PokemonFields.evs),
        baseStats = _getStats(json, PokemonFields.baseStats);

  @override
  Pokemon.fromDB(Map<String, dynamic> json)
      : name = json[PokemonFields.name],
        isDefault = json[PokemonFields.isDefault] == 1,
        id = json[PokemonFields.id],
        order = json[PokemonFields.order],
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP],
        type1 = Typing.values[json[PokemonFields.type1]],
        type2 = Typing.values[json[PokemonFields.type2]],
        ability1 = json[PokemonFields.ability1],
        ability2 = json[PokemonFields.abilityH],
        abilityH = json[PokemonFields.abilityH],
        species = json[PokemonFields.species],
        heldItems = (json[PokemonFields.heldItems] as String).toListInt(),
        moves = _getMovesFromDB(json[PokemonFields.moves]),
        evs = Stats.fromString(json[PokemonFields.evs]),
        baseStats = Stats.fromString(json[PokemonFields.baseStats]);

  @override
  Map<String, dynamic> toDB() => {
        PokemonFields.name: name,
        PokemonFields.isDefault: isDefault ? 1 : 0,
        PokemonFields.id: id,
        PokemonFields.order: order,
        PokemonFields.height: height,
        PokemonFields.weight: weight,
        PokemonFields.baseXP: baseXP,
        PokemonFields.type1: type1.index,
        PokemonFields.type2: type2.index,
        PokemonFields.ability1: ability1,
        PokemonFields.ability2: ability2,
        PokemonFields.abilityH: abilityH,
        PokemonFields.species: species,
        PokemonFields.heldItems: heldItems.join(separator),
        PokemonFields.moves: moves.join(separator),
        PokemonFields.evs: evs.toString(),
        PokemonFields.baseStats: baseStats.getString(),
      };

  // Helper Functions
  static int _getSpecies(Map<String, dynamic> json) {
    String url = json[PokemonFields.species]["url"];
    return url.getId();
  }

  static Stats _getStats(Map<String, dynamic> json, String field) {
    List<dynamic> maps = json["stats"];
    List<int> list = [];

    for (final map in maps) {
      list.add(map[field]);
    }

    return Stats.fromList(list);
  }

  static Typing _getType(Map<String, dynamic> json, int index) {
    List<dynamic> types = json["types"];
    Iterable slot = types.where((type) => type["slot"] == index);

    if (slot.isEmpty) return Typing.error;

    String url = slot.first["type"]["url"];

    // Special Conversion for Irregular Types
    int id = url.getId();
    if (id == 10001) {
      id = 0;
    } else if (id == 10002) {
      id = 20;
    }

    return Typing.values[id];
  }

  static int _getAbility(Map<String, dynamic> json, int index) {
    List<dynamic> abilities = json["abilities"];
    Iterable slot = abilities.where((ability) => ability["slot"] == index);

    int abilityId = 0;
    if (slot.isNotEmpty) {
      String url = slot.first["ability"]["url"];
      abilityId = url.getId();
    }

    return abilityId;
  }

  static List<int> _getHeldItems(Map<String, dynamic> json) {
    List<int> items = [];

    for (final item in json[PokemonFields.heldItems]) {
      String url = item["item"]["url"];
      items.add(url.getId());
    }

    return items;
  }

  static List<Map<String, dynamic>> _getMoves(Map<String, dynamic> json) {
    List<Map<String, dynamic>> results = [];

    for (final move in json[PokemonFields.moves]) {
      String url = move["move"]["url"];
      Map<String, dynamic> details = (move["version_group_details"] as List).last;

      results.add({
        "id": url.getId(),
        "level": details["level_learned_at"],
        "method": details["move_learn_method"]["name"],
      });
    }

    return results;
  }

  static List<Map<String, dynamic>> _getMovesFromDB(String encoded) {
    List<String> jsons = encoded.split(separator);
    if (jsons.isEmpty) return [];

    List<Map<String, dynamic>> results = [];
    jsons.map((j) => results.add(jsonDecode(j)));
    return results.toList();
  }
}

class PokemonFields {
  const PokemonFields();

  // Non-Integers
  static const String name = "name";
  static const String isDefault = "is_default";

  // Standard Integers
  static const String id = "id";
  static const String order = "ordera";
  static const String height = "height";
  static const String weight = "weight";
  static const String baseXP = "base_experience";
  static const String species = "species";

  // Foreign Keys
  static const String type1 = "type_1";
  static const String type2 = "type_2";
  static const String ability1 = "ability_1";
  static const String ability2 = "ability_2";
  static const String abilityH = "ability_hidden";

  // Multiple Foreign Keys
  static const String moves = "moves";
  static const String heldItems = "held_items";

  // Base Stats
  static const String evs = "effort";
  static const String baseStats = "base_stat";

  // List of All Fields
  static const List<String> fields = [
    name,
    isDefault,
    id,
    order,
    height,
    weight,
    baseXP,
    type1,
    type2,
    ability1,
    ability2,
    abilityH,
    species,
    heldItems,
    moves,
    evs,
    baseStats,
  ];
}

const String pokemonMaker = """
  CREATE TABLE IF NOT EXISTS $pokemonModel(
    ${PokemonFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${PokemonFields.name} TEXT NOT NULL,
    ${PokemonFields.isDefault} INTEGER NOT NULL,
    ${PokemonFields.order} INTEGER NOT NULL,
    ${PokemonFields.height} INTEGER NOT NULL,
    ${PokemonFields.weight} INTEGER NOT NULL,
    ${PokemonFields.baseXP} INTEGER NOT NULL,
    ${PokemonFields.type1} INTEGER NOT NULL,
    ${PokemonFields.type2} INTEGER NOT NULL,
    ${PokemonFields.ability1} INTEGER NOT NULL,
    ${PokemonFields.ability2} INTEGER NOT NULL,
    ${PokemonFields.abilityH} INTEGER NOT NULL,
    ${PokemonFields.species} INTEGER NOT NULL,
    ${PokemonFields.heldItems} TEXT NOT NULL,
    ${PokemonFields.moves} TEXT NOT NULL,
    ${PokemonFields.evs} TEXT NOT NULL,
    ${PokemonFields.baseStats} TEXT NOT NULL,
    FOREIGN KEY (${PokemonFields.ability1}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.ability2}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.abilityH}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.species}) REFERENCES $speciesModel (id)
  )""";
