import '_model.dart';
import 'target.dart';
import 'pkmn_type.dart';
import 'generation.dart';
import 'damage_class.dart';

import 'package:pokedex/extensions/string.dart';

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

  // JSON Parsing
  @override
  Move.fromAPI(Map<String, dynamic> json)
      : name = json[MoveFields.name],
        effect = _getEffect(json),
        id = json[MoveFields.id],
        pp = json[MoveFields.pp],
        power = json[MoveFields.power],
        accuracy = json[MoveFields.pp],
        priority = json[MoveFields.priority],
        effectChance = json[MoveFields.effectChance],
        type = _getById(json, MoveFields.type),
        target = _getById(json, MoveFields.target),
        generation = _getById(json, MoveFields.generation),
        damageClass = _getById(json, MoveFields.damageClass),
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
        type = json[MoveFields.type],
        target = json[MoveFields.target],
        generation = json[MoveFields.generation],
        damageClass = json[MoveFields.damageClass],
        statChanges = (json[MoveFields.statChanges] as String).toListInt();

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
        MoveFields.statChanges: statChanges.join(separator)
      };

  // Helper Functions
  static String _getEffect(Map<String, dynamic> json) {
    List<Map> effects = json["effect_entries"];
    Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
    return slot.first[MoveFields.effect];
  }

  static List<int> _getStatChanges(Map<String, dynamic> json) {
    List<Map> maps = json[MoveFields.statChanges];
    List<int> changes = List.filled(6, 0);

    for (final map in maps) {
      String url = map["stat"]["url"];
      int stat = url.getId() - 1;

      changes[stat] = map["chance"];
    }

    return changes;
  }

  static int _getById(Map<String, dynamic> json, String field) {
    String url = json[field]["url"];
    return url.getId();
  }
}

class MoveFields {
  const MoveFields();

  // Strings
  static const String name = "name";
  static const String effect = "short_effect";
  static const String statChanges = "stat_changes";

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
  CREATE TABLE $moveModel(
    ${MoveFields.id} INTEGER PRIMARY KET NOT NULL,
    ${MoveFields.name} TEXT NOT NULL,
    ${MoveFields.effect} TEXT NOT NULL,
    ${MoveFields.statChanges} TEXT NOT NULL,
    ${MoveFields.pp} INTEGER NOT NULL,
    ${MoveFields.power} INTEGER NOT NULL,
    ${MoveFields.accuracy} INTEGER NOT NULL,
    ${MoveFields.priority} INTEGER NOT NULL,
    ${MoveFields.effectChance} INTEGER NOT NULL,
    ${MoveFields.type} INTEGER NOT NULL,
    ${MoveFields.target} INTEGER NOT NULL,
    ${MoveFields.generation} INTEGER NOT NULL,
    ${MoveFields.damageClass} INTEGER NOT NULL,
    FOREIGN KEY (${MoveFields.type}) REFERENCES $pkmnTypeModel (id),
    FOREIGN KEY (${MoveFields.target}) REFERENCES $targetModel (id),
    FOREIGN KEY (${MoveFields.generation}) REFERENCES $generationModel (id),
    FOREIGN KEY (${MoveFields.damageClass}) REFERENCES $damageClassModel (id),
  )""";
