import 'package:pokedex/types/enums/generation.dart';
import 'package:pokedex/extensions/string.dart';

import '_model.dart';

const String abilityModel = "ability";

class Ability implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  static List<String> getFields() => AbilityFields.fields;

  // Strings
  final String name;
  final String effect;

  // Integers
  final int id;
  final Generation generation;

  //----------------------------------------------------------------------------

  // Core Constructor

  Ability({
    required this.id,
    required this.name,
    required this.effect,
    required this.generation,
  });

  Ability.filler()
      : id = 0,
        name = blank,
        effect = blank,
        generation = Generation.error;

  // JSON Parsing
  @override
  Ability.fromAPI(Map<String, dynamic> json)
      : id = json[AbilityFields.id] ?? 0,
        name = json[AbilityFields.name] ?? blank,
        effect = _getEffect(json),
        generation = _getGeneration(json);

  @override
  Ability.fromDB(Map<String, dynamic> json)
      : id = json[AbilityFields.id],
        name = json[AbilityFields.name],
        effect = json[AbilityFields.effect],
        generation = Generation.values[json[AbilityFields.generation]];

  @override
  Map<String, dynamic> toDB() => {
        AbilityFields.id: id,
        AbilityFields.name: name,
        AbilityFields.effect: effect,
        AbilityFields.generation: generation.index,
      };

  // Helper Functions
  static String _getEffect(Map<String, dynamic> json) {
    List<dynamic> effects = json["effect_entries"] ?? [];
    String field = AbilityFields.effect;

    if (effects.isEmpty) {
      effects = json["flavor_text_entries"];
      field = "flavor_text";
    }

    String? effect;
    if (effects.isNotEmpty) {
      Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
      effect = slot.first[field];
    }

    return effect ?? blank;
  }

  static Generation _getGeneration(Map<String, dynamic> json) {
    String url = json[AbilityFields.generation]["url"] ?? "000";
    return Generation.values[url.getId()];
  }
}

class AbilityFields {
  const AbilityFields();

  // Strings
  static const String name = "name";
  static const String effect = "short_effect";

  // Integers
  static const String id = "id";
  static const String generation = "generation"; // Foreign Key

  static const List<String> fields = [id, name, effect, generation];
}

const String abilityMaker = """
  CREATE TABLE IF NOT EXISTS $abilityModel(
    ${AbilityFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${AbilityFields.name} TEXT NOT NULL,
    ${AbilityFields.effect} TEXT NOT NULL,
    ${AbilityFields.generation} INTEGER NOT NULL
  )""";
