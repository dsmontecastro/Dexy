import '_model.dart';

const String abilityTable = "ability";

class Ability implements Table {
  //----------------------------------------------------------------------------

  @override
  List<String> getFields() => AbilityFields.fields;

  // Integers
  final int id;
  final int generation; // Foreign

  // Strings
  final String name;
  final String effect;
  final List<int> pokemon;

  //----------------------------------------------------------------------------

  // Core Constructor
  Ability(
      {required this.id,
      required this.name,
      required this.effect,
      required this.pokemon,
      required this.generation});

  // JSON Parsing
  @override
  Ability fromJson(Map<String, dynamic> json) => Ability.fromJson(json);

  Ability.fromJson(Map<String, dynamic> json)
      : id = json[AbilityFields.id],
        name = json[AbilityFields.name],
        effect = json[AbilityFields.effect],
        pokemon = json[AbilityFields.pokemon],
        generation = json[AbilityFields.generation];

  @override
  Map<String, dynamic> toJson() => {
        AbilityFields.id: id,
        AbilityFields.name: name,
        AbilityFields.effect: effect,
        AbilityFields.pokemon: pokemon,
        AbilityFields.generation: generation
      };
}

class AbilityFields {
  static const List<String> fields = [id, name, effect, pokemon, generation];

  static const String id = "ID";
  static const String name = "Name";
  static const String effect = "Effect";
  static const String pokemon = "Pokemon";
  static const String generation = "Generation"; // Foreign
}
