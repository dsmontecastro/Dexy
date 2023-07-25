import 'dart:convert';

import '_model.dart';
import 'ability.dart';
import 'typing.dart';

import 'package:pokedex/extensions/string.dart';

import 'species.dart';

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

  // Base Stats
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  // Foreign Keys
  final int type1;
  final int type2;
  final int ability1;
  final int ability2;
  final int abilityH;
  final int species;

  // Multiple Foreign Keys
  final List<int> evs;
  final List<int> heldItems;
  final List<Map<String, dynamic>> moves;

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
      required this.hp,
      required this.attack,
      required this.defense,
      required this.specialAttack,
      required this.specialDefense,
      required this.speed,
      required this.type1,
      required this.type2,
      required this.ability1,
      required this.ability2,
      required this.abilityH,
      required this.species,
      required this.evs,
      required this.moves,
      required this.heldItems});

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
        hp = 0,
        speed = 0,
        attack = 0,
        defense = 0,
        specialAttack = 0,
        specialDefense = 0,
        type1 = 0,
        type2 = 0,
        ability1 = 0,
        ability2 = 0,
        abilityH = 0,
        species = 0,
        evs = [],
        heldItems = [],
        moves = [];

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
        order = json[PokemonFields.order],
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP],
        hp = json[0][PokemonFields.hp],
        attack = json[1][PokemonFields.attack],
        defense = json[2][PokemonFields.defense],
        specialAttack = json[3][PokemonFields.specialAttack],
        specialDefense = json[4][PokemonFields.specialDefense],
        speed = json[5][PokemonFields.speed],
        type1 = _getType(json, 1),
        type2 = _getType(json, 2),
        ability1 = _getPokemon(json, 1),
        ability2 = _getPokemon(json, 2),
        abilityH = _getPokemon(json, 3),
        species = json[PokemonFields.species],
        evs = _getEVs(json),
        heldItems = _getHeldItems(json),
        moves = _getMoves(json);

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
        hp = json[PokemonFields.hp],
        speed = json[PokemonFields.speed],
        attack = json[PokemonFields.attack],
        defense = json[PokemonFields.defense],
        specialAttack = json[PokemonFields.specialAttack],
        specialDefense = json[PokemonFields.specialDefense],
        type1 = json[PokemonFields.type1],
        type2 = json[PokemonFields.type2],
        ability1 = json[PokemonFields.ability1],
        ability2 = json[PokemonFields.abilityH],
        abilityH = json[PokemonFields.abilityH],
        species = json[PokemonFields.species],
        evs = (json[PokemonFields.evs] as String).toListInt(),
        heldItems = (json[PokemonFields.heldItems] as String).toListInt(),
        moves = _getMovesFromDB(json[PokemonFields.moves]);

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
        PokemonFields.hp: hp,
        PokemonFields.speed: speed,
        PokemonFields.attack: attack,
        PokemonFields.defense: defense,
        PokemonFields.specialAttack: specialAttack,
        PokemonFields.specialDefense: specialDefense,
        PokemonFields.type1: type1,
        PokemonFields.type2: type2,
        PokemonFields.ability1: ability1,
        PokemonFields.ability2: ability2,
        PokemonFields.abilityH: abilityH,
        PokemonFields.species: species,
        PokemonFields.evs: evs.join(separator),
        PokemonFields.moves: moves.join(separator),
        PokemonFields.heldItems: heldItems.join(separator),
      };

  // Helper Functions
  static List<int> _getEVs(Map<String, dynamic> json) =>
      [for (final stat in json["stats"]) stat["effort"] as int];
  //  {
  //   List<int> evs = List.filled(Stat.values.length, 0);
  //   List<Map> stats = json["stats"];

  //   for (int i = 0; i < stats.length; i++) {
  //     evs[i] = int.parse(stats[i]["effort"]);
  //   }
  // }

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
    return jsons
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .toList();
    // List<Map<String, dynamic>> moves = [];

    // for (final json in jsons) {
    //   Map<String, dynamic> move = jsonDecode(json);
    //   moves.add(move);
    // }

    // return moves;
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
  static const String order = "order";
  static const String height = "height";
  static const String weight = "weight";
  static const String baseXP = "base_experience";
  static const String species = "species";

  // Base Stats
  static const String baseStat = "base_stat"; // Not a column

  static const String hp = "hp";
  static const String speed = "speed";
  static const String attack = "attack";
  static const String defense = "defense";
  static const String specialAttack = "special-attack";
  static const String specialDefense = "special-defense";
  static const String evs = "evs";

  // Foreign Keys
  static const String type1 = "type-1";
  static const String type2 = "type-2";
  static const String ability1 = "ability-1";
  static const String ability2 = "ability-2";
  static const String abilityH = "ability-hidden";

  // Multiple Foreign Keys
  static const String moves = "moves";
  static const String heldItems = "held_items";

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
    hp,
    speed,
    attack,
    defense,
    specialAttack,
    specialDefense,
    type1,
    type2,
    ability1,
    ability2,
    abilityH,
    species,
    evs,
    moves,
    heldItems,
  ];
}

const String pokemonMaker = """
  CREATE TABLE $pokemonModel(
    ${PokemonFields.id} INTEGER PRIMARY KET NOT NULL,
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
    ${PokemonFields.hp} INTEGER NOT NULL,
    ${PokemonFields.speed} INTEGER NOT NULL,
    ${PokemonFields.attack} INTEGER NOT NULL,
    ${PokemonFields.defense} INTEGER NOT NULL,
    ${PokemonFields.specialAttack} INTEGER NOT NULL,
    ${PokemonFields.specialDefense} INTEGER NOT NULL,
    ${PokemonFields.speed} INTEGER NOT NULL,
    ${PokemonFields.type1} INTEGER NOT NULL,
    ${PokemonFields.type2} INTEGER NOT NULL,
    ${PokemonFields.ability1} INTEGER NOT NULL,
    ${PokemonFields.ability2} INTEGER NOT NULL,
    ${PokemonFields.abilityH} INTEGER NOT NULL,
    ${PokemonFields.species} INTEGER NOT NULL,
    ${PokemonFields.evs} TEXT NOT NULL,
    ${PokemonFields.moves} TEXT NOT NULL,
    ${PokemonFields.heldItems} TEXT NOT NULL,
    FOREIGN KEY (${PokemonFields.type1}) REFERENCES $typingModel (id),
    FOREIGN KEY (${PokemonFields.type2}) REFERENCES $typingModel (id),
    FOREIGN KEY (${PokemonFields.ability1}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.ability2}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.abilityH}) REFERENCES $abilityModel (id),
    FOREIGN KEY (${PokemonFields.species}) REFERENCES $speciesModel (id)
  )""";
