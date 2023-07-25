import 'dart:convert';

import '_model.dart';
import '_classes.dart';

import 'ability.dart';
import 'typing.dart';
import 'species.dart';

import 'package:pokedex/extensions/string.dart';

const String pokemonModel = "pokemon";

class Pokemon implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  // Strings
  final String name;
  final String icon;
  final String image;

  // Booleans
  bool caught;
  bool favorite;
  final bool isDefault;

  // Integers
  final int id;
  final int order;
  final int height;
  final int weight;
  final int baseXP;

  // Foreign Keys
  final int type1;
  final int type2;
  final int ability1;
  final int ability2;
  final int abilityH;
  final int species;

  // List of Foreign Keys
  final List<int> heldItems;
  final List<Map<String, dynamic>> moves;

  // Stat Modifiers
  final Stats evs;
  final Stats baseStats;

  //----------------------------------------------------------------------------

  // Core Constructor
  Pokemon(
      {required this.name,
      required this.icon,
      required this.image,
      this.caught = false,
      this.favorite = false,
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
  Pokemon.fill()
      : name = "---",
        icon = "-",
        image = "-",
        isDefault = false,
        favorite = false,
        caught = false,
        id = 0,
        order = 0,
        height = 0,
        weight = 0,
        baseXP = 0,
        type1 = 0,
        type2 = 0,
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
      : caught = json[PokemonFields.caught] ?? false,
        favorite = json[PokemonFields.favorite] ?? false,
        name = json[PokemonFields.name],
        icon = json[PokemonFields.icon],
        image = json[PokemonFields.image],
        isDefault = json[PokemonFields.isDefault],
        id = json[PokemonFields.id],
        order = json["order"], // problematic string in DB
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP],
        type1 = _getType(json, 1),
        type2 = _getType(json, 2),
        ability1 = _getPokemon(json, 1),
        ability2 = _getPokemon(json, 2),
        abilityH = _getPokemon(json, 3),
        species = json[PokemonFields.species],
        heldItems = _getHeldItems(json),
        moves = _getMoves(json),
        evs = _getStats(json, PokemonFields.evs),
        baseStats = _getStats(json, PokemonFields.baseStats);

  @override
  Pokemon.fromDB(Map<String, dynamic> json)
      : name = json[PokemonFields.name],
        icon = json[PokemonFields.icon],
        image = json[PokemonFields.image],
        isDefault = json[PokemonFields.isDefault] == 1,
        favorite = json[PokemonFields.favorite] == 1,
        caught = json[PokemonFields.caught] == 1,
        id = json[PokemonFields.id],
        order = json[PokemonFields.order],
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP],
        type1 = json[PokemonFields.type1],
        type2 = json[PokemonFields.type2],
        ability1 = json[PokemonFields.ability1],
        ability2 = json[PokemonFields.abilityH],
        abilityH = json[PokemonFields.abilityH],
        species = json[PokemonFields.species],
        heldItems = (json[PokemonFields.heldItems] as String).toListInt(),
        moves = _getMovesFromDB(json[PokemonFields.moves]),
        evs = Stats.fromList(json[PokemonFields.evs]),
        baseStats = Stats.fromList(json[PokemonFields.baseStats]);

  @override
  Map<String, dynamic> toDB() => {
        PokemonFields.name: name,
        PokemonFields.icon: icon,
        PokemonFields.image: image,
        PokemonFields.isDefault: isDefault ? 1 : 0,
        PokemonFields.favorite: favorite ? 1 : 0,
        PokemonFields.caught: caught ? 1 : 0,
        PokemonFields.id: id,
        PokemonFields.order: order,
        PokemonFields.height: height,
        PokemonFields.weight: weight,
        PokemonFields.baseXP: baseXP,
        PokemonFields.type1: type1,
        PokemonFields.type2: type2,
        PokemonFields.ability1: ability1,
        PokemonFields.ability2: ability2,
        PokemonFields.abilityH: abilityH,
        PokemonFields.species: species,
        PokemonFields.moves: moves.join(separator),
        PokemonFields.heldItems: heldItems.join(separator),
        PokemonFields.evs: evs.toString(),
        PokemonFields.baseStats: baseStats.toString(),
      };

  // Helper Functions
  static Stats _getStats(Map<String, dynamic> json, String type) {
    List<int> stats = [for (final stat in json["stats"]) stat[type] as int];
    return Stats.fromList(stats);
  }

  static int _getType(Map<String, dynamic> json, int index) {
    List<Map> types = json["types"];
    Iterable slot = types.where((slot) => slot["slot"] == index);
    return slot.isEmpty ? 0 : int.parse(slot.first["type"]["url"][-2]);
  }

  static int _getPokemon(Map json, int index) {
    List<Map> abilities = json["abilities"];
    Iterable slot = abilities.where((slot) => slot["slot"] == index);
    return slot.isEmpty ? 0 : int.parse(slot.first["ability"]["url"][-2]);
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
    List<Map<String, dynamic>> moves = [];

    for (final move in json[PokemonFields.moves]) {
      String url = move["move"]["url"];
      Map details = move["version_group_details"][-1];

      moves.add({
        "id": url.getId(),
        "level": int.parse(details["level_learned_at"]),
        "method": details["move_learn_method"]["name"],
      });
    }

    return moves;
  }

  static List<Map<String, dynamic>> _getMovesFromDB(String encoded) {
    List<String> jsons = encoded.split(separator);
    return jsons.map((j) => jsonDecode(j) as Map<String, dynamic>).toList();
  }
}

class PokemonFields {
  const PokemonFields();

  // Strings
  static const String name = "name";
  static const String icon = "icon";
  static const String image = "image";

  // Booleans
  static const String caught = "caught";
  static const String favorite = "favorite";
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
    icon,
    image,
    caught,
    favorite,
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
    moves,
    heldItems,
    evs,
    baseStats,
  ];
}

const String pokemonMaker = """
  CREATE TABLE $pokemonModel(
    ${PokemonFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${PokemonFields.name} TEXT NOT NULL,
    ${PokemonFields.icon} TEXT NOT NULL,
    ${PokemonFields.image} TEXT NOT NULL,
    ${PokemonFields.caught} INTEGER NOT NULL,
    ${PokemonFields.favorite} INTEGER NOT NULL,
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
    ${PokemonFields.moves} TEXT NOT NULL,
    ${PokemonFields.heldItems} TEXT NOT NULL,
    ${PokemonFields.evs} TEXT NOT NULL,
    ${PokemonFields.baseStats} TEXT NOT NULL,
    FOREIGN KEY (${PokemonFields.type1}) REFERENCES $typingModel (id),
    FOREIGN KEY (${PokemonFields.type2}) REFERENCES $typingModel (id),
    FOREIGN KEY (${PokemonFields.ability1}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.ability2}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.abilityH}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.species}) REFERENCES $speciesModel (id)
  )""";
