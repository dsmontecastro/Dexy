import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String moveModel = "move";

class Move implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => MoveFields.fields;

  // Strings
  final String name;
  final String effect;

  // Integers
  final int id;
  final int pp;
  final int power;
  final int accuracy;
  final int priority;
  final int effectChance;
  final List<int> statChanges;

  // Foreign Keys
  final int type;
  final int target;
  final int generation;
  final int damageClass;
  // final List<int> pokemon;

  //----------------------------------------------------------------------------

  // Core Constructor
  Move(
      {required this.name,
      required this.effect,
      required this.id,
      required this.pp,
      required this.power,
      required this.accuracy,
      required this.priority,
      required this.effectChance,
      required this.type,
      required this.target,
      required this.generation,
      required this.damageClass,
      // required this.pokemon,
      required this.statChanges});

  // JSON Parsing
  Move.make(Map<String, dynamic> json)
      : name = json[MoveFields.name],
        effect = json[MoveFields.effect],
        id = json[MoveFields.id],
        pp = json[MoveFields.pp],
        power = json[MoveFields.power],
        accuracy = json[MoveFields.pp],
        priority = json[MoveFields.priority],
        effectChance = json[MoveFields.effectChance],
        type = json[MoveFields.type],
        target = json[MoveFields.target],
        generation = json[MoveFields.generation],
        damageClass = json[MoveFields.damageClass],
        // pokemon = json[MoveFields.pokemon],
        statChanges = json[MoveFields.statChanges];

  @override
  Move fromDB(Map<String, dynamic> json) {
    // Convert from String to List<int>
    json[MoveFields.statChanges] = (json[MoveFields.statChanges] as String).toListInt();
    return Move.make(json);
  }

  @override
  Move fromAPI(Map<String, dynamic> json) {
    // Re-map some Fields & Keys

    // Properties
    json[MoveFields.effect] = _getEffect(json);
    json[MoveFields.statChanges] = _getStatChanges(json);

    // Foreign Keys
    json[MoveFields.type] = _getById(json, MoveFields.type);
    json[MoveFields.target] = _getById(json, MoveFields.target);
    json[MoveFields.generation] = _getById(json, MoveFields.generation);
    json[MoveFields.damageClass] = _getById(json, MoveFields.damageClass);
    // json[MoveFields.pokemon] = _getPokemon(json);

    return Move.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        MoveFields.name: name,
        MoveFields.effect: effect,
        MoveFields.id: id,
        MoveFields.pp: pp,
        MoveFields.power: power,
        MoveFields.accuracy: accuracy,
        MoveFields.priority: priority,
        MoveFields.effectChance: effectChance,
        MoveFields.type: type,
        MoveFields.target: target,
        MoveFields.generation: generation,
        MoveFields.damageClass: damageClass,
        // MoveFields.pokemon: pokemon,
        MoveFields.statChanges: statChanges.join(separator)
      };

  // Helper Functions
  String _getEffect(Map<String, dynamic> json) {
    List<Map> effects = json["effect_entries"];
    Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
    return slot.first[MoveFields.effect];
  }

  List<int> _getStatChanges(Map<String, dynamic> json) {
    List<Map> maps = json[MoveFields.statChanges];
    List<int> changes = List.filled(6, 0);

    for (final map in maps) {
      String url = map["stat"]["url"];
      int stat = url.getId() - 1;

      changes[stat] = map["chance"];
    }

    return changes;
  }

  int _getById(Map<String, dynamic> json, String field) {
    String url = json[field]["url"];
    return url.getId();
  }

  // List<int> _getPokemon(Map<String, dynamic> json) {
  //   List<int> pokemons = [];

  //   for (final pokemon in json[MoveFields.pokemon]) {
  //     String url = pokemon["url"];
  //     pokemons.add(url.getId());
  //   }

  //   return pokemons;
  // }
}

class MoveFields {
  // Strings
  static const String name = "name";
  static const String effect = "short_effect";

  // Integers
  static const String id = "id";
  static const String pp = "pp";
  static const String power = "power";
  static const String accuracy = "accuracy";
  static const String priority = "priority";
  static const String effectChance = "effect_chance";
  static const String statChanges = "stat_changes";

  // Foreign Keys
  static const String type = "type";
  static const String target = "target";
  static const String generation = "generation";
  static const String damageClass = "damage_class";
  // static const String pokemon = "learned_by_pokemon";

  static const List<String> fields = [
    name,
    effect,
    id,
    pp,
    power,
    accuracy,
    priority,
    effectChance,
    damageClass,
    statChanges,
    type,
    target,
    generation,
    // pokemon,
  ];
}
