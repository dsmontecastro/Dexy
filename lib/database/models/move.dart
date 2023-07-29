import '_model.dart';

import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/types/enums/damage.dart';
import 'package:pokedex/types/enums/target.dart';
import 'package:pokedex/types/enums/typing.dart';
import 'package:pokedex/types/enums/generation.dart';
import 'package:pokedex/types/classes/stats.dart';

const String moveModel = "move";

class Move implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  // Strings
  final String name;
  final String effect;

  // Integers
  final int id;
  final int pp;
  final int? power;
  final int? accuracy;
  final int? priority;
  final int? effectChance;

  // ENUM Keys
  final Typing type;
  final Target target;
  final Generation generation;
  final DamageClass damageClass;
  final Stats statChanges;

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
      required this.statChanges});

  Move.filler()
      : name = blank,
        effect = blank,
        id = 0,
        pp = 0,
        power = null,
        accuracy = null,
        priority = null,
        effectChance = null,
        type = Typing.error,
        target = Target.error,
        generation = Generation.error,
        damageClass = DamageClass.error,
        statChanges = Stats.blank();

  // JSON Parsing
  @override
  Move.fromAPI(Map<String, dynamic> json)
      : name = json[MoveFields.name],
        effect = _getEffect(json),
        id = json[MoveFields.id],
        pp = json[MoveFields.pp] ?? 0,
        power = json[MoveFields.power],
        accuracy = json[MoveFields.pp],
        priority = json[MoveFields.priority],
        effectChance = json[MoveFields.effectChance],
        type = Typing.values[_getById(json, MoveFields.type)],
        target = Target.values[_getById(json, MoveFields.target)],
        generation = Generation.values[_getById(json, MoveFields.generation)],
        damageClass = DamageClass.values[_getById(json, MoveFields.damageClass)],
        statChanges = _getStatChanges(json);

  @override
  Move.fromDB(Map<String, dynamic> json)
      : name = json[MoveFields.name],
        effect = json[MoveFields.effect],
        id = json[MoveFields.id],
        pp = json[MoveFields.pp],
        power = json[MoveFields.power],
        accuracy = json[MoveFields.pp],
        priority = json[MoveFields.priority],
        effectChance = json[MoveFields.effectChance],
        type = Typing.values[json[MoveFields.type]],
        target = Target.values[json[MoveFields.target]],
        generation = Generation.values[json[MoveFields.generation]],
        damageClass = DamageClass.values[json[MoveFields.damageClass]],
        statChanges = Stats.fromString(json[MoveFields.statChanges]);

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
        MoveFields.type: type.index,
        MoveFields.target: target.index,
        MoveFields.generation: generation.index,
        MoveFields.damageClass: damageClass.index,
        MoveFields.statChanges: statChanges.toString()
      };

  // Helper Functions
  static int _getById(Map<String, dynamic> json, String field) {
    String url = json[field]["url"];
    int id = url.getId();

    // Special Conversion for Irregular Types
    if (field == MoveFields.type) {
      if (id == 10001) {
        id = 0;
      } else if (id == 10002) {
        id = 20;
      }
    }

    return id;
  }

  static String _getEffect(Map<String, dynamic> json) {
    List<dynamic> effects = json["effect_entries"] ?? [];
    String field = MoveFields.effect;

    if (effects.isEmpty) {
      effects = json["flavor_text_entries"];
      field = "flavor_text";
    }

    String? text;
    if (effects.isNotEmpty) {
      Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
      text = slot.first[field];
    }

    return text ?? blank;
  }

  static Stats _getStatChanges(Map<String, dynamic> json) {
    List<dynamic> maps = json[MoveFields.statChanges];

    if (maps.isEmpty) return Stats.blank();

    List<int> changes = List.filled(Stats.count, 0);

    for (final map in maps) {
      String url = map["stat"]["url"];
      int stat = url.getId() - 1;
      changes[stat] = map["change"];
    }

    return Stats.fromList(changes);
  }
}

class MoveFields {
  const MoveFields();

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

  // Foreign Keys
  static const String type = "type";
  static const String target = "target";
  static const String generation = "generation";
  static const String damageClass = "damage_class";
  static const String statChanges = "stat_changes";

  static const List<String> fields = [
    name,
    effect,
    statChanges,
    id,
    pp,
    power,
    accuracy,
    priority,
    effectChance,
    type,
    target,
    generation,
    damageClass,
    // pokemon,
  ];
}

const String moveMaker = """
  CREATE TABLE IF NOT EXISTS $moveModel(
    ${MoveFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${MoveFields.name} TEXT NOT NULL,
    ${MoveFields.effect} TEXT NOT NULL,
    ${MoveFields.pp} INTEGER NOT NULL,
    ${MoveFields.power} INTEGER,
    ${MoveFields.accuracy} INTEGER,
    ${MoveFields.priority} INTEGER,
    ${MoveFields.effectChance} INTEGER,
    ${MoveFields.type} INTEGER NOT NULL,
    ${MoveFields.target} INTEGER NOT NULL,
    ${MoveFields.generation} INTEGER NOT NULL,
    ${MoveFields.damageClass} INTEGER NOT NULL,
    ${MoveFields.statChanges} TEXT NOT NULL
  )""";
