import '_enums.dart';
import '_model.dart';

const String moveTable = "move";

class Move implements Table {
  //----------------------------------------------------------------------------

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
  final DamageType damageType;
  final List<Map<String, int>> statChanges;

  // Foreign Keys
  final int type;
  final int target;
  final int generation;
  final List<int> pokemon;

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
      required this.damageType,
      required this.type,
      required this.target,
      required this.generation,
      this.pokemon = const [],
      this.statChanges = const []});

  // JSON Parsing
  @override
  Move fromJson(Map<String, dynamic> json) => Move.fromJson(json);

  Move.fromJson(Map<String, dynamic> json)
      : name = json[MoveFields.name],
        effect = json[MoveFields.effect],
        id = json[MoveFields.id],
        pp = json[MoveFields.pp],
        power = json[MoveFields.power],
        accuracy = json[MoveFields.pp],
        priority = json[MoveFields.priority],
        effectChance = json[MoveFields.effectChance],
        damageType = json[MoveFields.damageType],
        type = json[MoveFields.type],
        target = json[MoveFields.target],
        generation = json[MoveFields.generation],
        pokemon = json[MoveFields.pokemon],
        statChanges = json[MoveFields.statChanges];

  @override
  Map<String, dynamic> toJson() => {
        MoveFields.name: name,
        MoveFields.effect: effect,
        MoveFields.id: id,
        MoveFields.pp: pp,
        MoveFields.power: power,
        MoveFields.accuracy: accuracy,
        MoveFields.priority: priority,
        MoveFields.effectChance: effectChance,
        MoveFields.damageType: damageType,
        MoveFields.type: type,
        MoveFields.target: target,
        MoveFields.generation: generation,
        MoveFields.pokemon: pokemon,
        MoveFields.statChanges: id
      };
}

class MoveFields {
  // Strings
  static const String name = "Name";
  static const String effect = "Effect";

  // Integers
  static const String id = "ID";
  static const String pp = "PP";
  static const String power = "Power";
  static const String accuracy = "Accuracy";
  static const String priority = "Priority";
  static const String effectChance = "Effect Chance";
  static const String damageType = "Damage Type";
  static const String statChanges = "Stat Changes";

  // Foreign Keys
  static const String type = "Type";
  static const String target = "Target";
  static const String generation = "Generation";
  static const String pokemon = "Pokemon";

  static const List<String> fields = [
    name,
    effect,
    id,
    pp,
    power,
    accuracy,
    priority,
    effectChance,
    damageType,
    statChanges,
    type,
    target,
    generation,
    pokemon,
  ];
}
