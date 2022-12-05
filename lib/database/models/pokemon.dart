import 'dart:convert';

import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String pokemonModel = "pokemon";

class Pokemon extends Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => PokemonFields.fields;

  // Non-Integers
  final String name;
  final String icon;
  final String image;
  final bool favorite;
  final bool isDefault;

  // Integers
  final int id;
  final int order;
  final int height;
  final int weight;
  final int baseXP;
  final int species;

  // Base Stats
  final int hp;
  final int speed;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;

  // Foreign Keys
  final int type1;
  final int type2;
  final int ability1;
  final int ability2;
  final int abilityH;

  // Multiple Foreign Keys
  final List<int> evs;
  final List<int> heldItems;
  final List<Map<String, dynamic>> moves;

  //----------------------------------------------------------------------------

  // Core Constructor
  Pokemon({
    required this.name,
    required this.icon,
    required this.image,
    required this.favorite,
    required this.isDefault,
    required this.id,
    required this.order,
    required this.height,
    required this.weight,
    required this.baseXP,
    required this.species,
    required this.hp,
    required this.speed,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.type1,
    required this.type2,
    required this.ability1,
    required this.ability2,
    required this.abilityH,
    required this.evs,
    required this.moves,
    required this.heldItems,
  });

  // JSON Parsing
  Pokemon.make(Map<String, dynamic> json)
      : name = json[PokemonFields.name],
        icon = json[PokemonFields.icon],
        image = json[PokemonFields.image],
        favorite = json[PokemonFields.favorite],
        isDefault = json[PokemonFields.isDefault],
        id = json[PokemonFields.id],
        order = json[PokemonFields.order],
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP],
        species = json[PokemonFields.species],
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
        evs = json[PokemonFields.evs],
        moves = json[PokemonFields.moves],
        heldItems = json[PokemonFields.heldItems];

  @override
  Pokemon fromDB(Map<String, dynamic> json) {
    // Convert from String to List<int>

    json[PokemonFields.evs] = (json[PokemonFields.evs] as String).toListInt();
    json[PokemonFields.heldItems] = (json[PokemonFields.heldItems] as String).toListInt();

    json[PokemonFields.moves] = _getMovesFromDB(json[PokemonFields.moves]);

    return Pokemon.make(json);
  }

  @override
  Pokemon fromAPI(Map<String, dynamic> json) {
    // Re-map some Fields & Keys

    // Base Stats
    json[PokemonFields.hp] = json[0][PokemonFields.baseStat];
    json[PokemonFields.attack] = json[1][PokemonFields.baseStat];
    json[PokemonFields.defense] = json[2][PokemonFields.baseStat];
    json[PokemonFields.specialAttack] = json[3][PokemonFields.baseStat];
    json[PokemonFields.specialDefense] = json[4][PokemonFields.baseStat];
    json[PokemonFields.speed] = json[5][PokemonFields.baseStat];
    json[PokemonFields.speed] = _getEVs(json);

    // Foreign Key: Types
    json[PokemonFields.type1] = _getType(json, 1);
    json[PokemonFields.type2] = _getType(json, 2);

    // Foreign Key: Abilities
    json[PokemonFields.ability1] = _getAbility(json, 1);
    json[PokemonFields.ability2] = _getAbility(json, 2);
    json[PokemonFields.abilityH] = _getAbility(json, 3);

    // Lists of Foreign Keys
    json[PokemonFields.evs] = _getEVs(json);
    json[PokemonFields.moves] = _getMoves(json);
    json[PokemonFields.heldItems] = _getHeldItems(json);

    return Pokemon.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        PokemonFields.name: name,
        PokemonFields.icon: icon,
        PokemonFields.image: image,
        PokemonFields.isDefault: isDefault,
        PokemonFields.favorite: favorite,
        PokemonFields.id: id,
        PokemonFields.order: order,
        PokemonFields.height: height,
        PokemonFields.weight: weight,
        PokemonFields.baseXP: baseXP,
        PokemonFields.species: species,
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
        PokemonFields.evs: evs.join(separator),
        PokemonFields.moves: moves.join(separator),
        PokemonFields.heldItems: heldItems.join(separator),
      };

  // Helper Functions
  List<int> _getEVs(Map<String, dynamic> json) =>
      [for (final stat in json["stats"]) stat["effort"] as int];
  //  {
  //   List<int> evs = List.filled(Stat.values.length, 0);
  //   List<Map> stats = json["stats"];

  //   for (int i = 0; i < stats.length; i++) {
  //     evs[i] = int.parse(stats[i]["effort"]);
  //   }
  // }

  int _getType(Map<String, dynamic> json, int index) {
    List<Map> types = json["types"];
    Iterable slot = types.where((slot) => slot["slot"] == index);
    return slot.isEmpty ? 0 : int.parse(slot.first["type"]["url"][-2]);
  }

  int _getAbility(Map json, int index) {
    List<Map> abilities = json["abilities"];
    Iterable slot = abilities.where((slot) => slot["slot"] == index);
    return slot.isEmpty ? 0 : int.parse(slot.first["ability"]["url"][-2]);
  }

  List<int> _getHeldItems(Map<String, dynamic> json) {
    List<int> items = [];

    for (final item in json[PokemonFields.heldItems]) {
      String url = item["item"]["url"];
      items.add(url.getId());
    }

    return items;
  }

  List<Map<String, dynamic>> _getMoves(Map<String, dynamic> json) {
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

  List<Map<String, dynamic>> _getMovesFromDB(String encoded) {
    List<String> jsons = encoded.split(separator);
    return jsons.map((json) => jsonDecode(json) as Map<String, dynamic>).toList();
    // List<Map<String, dynamic>> moves = [];

    // for (final json in jsons) {
    //   Map<String, dynamic> move = jsonDecode(json);
    //   moves.add(move);
    // }

    // return moves;
  }
}

class PokemonFields {
  // Field Information

  // None-Integers
  static const String name = "name";
  static const String icon = "icon";
  static const String image = "image";
  static const String isDefault = "is_default";
  static const String favorite = "favorite";

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
    isDefault,
    favorite,
    id,
    order,
    height,
    weight,
    baseXP,
    species,
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
    moves,
    heldItems,
  ];
}
