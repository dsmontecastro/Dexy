import '_model.dart';
import 'generation.dart';

import 'package:pokedex/extensions/string.dart';

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
  final int generation; // Foreign Key

  //----------------------------------------------------------------------------

  // Core Constructor

  Ability({
    required this.id,
    required this.name,
    required this.effect,
    required this.generation,
  });

  // JSON Parsing
  @override
  Ability.fromAPI(Map<String, dynamic> json)
      : id = json[AbilityFields.id],
        name = json[AbilityFields.name],
        effect = _getEffect(json),
        generation = _getGeneration(json);

  @override
  Ability.fromDB(Map<String, dynamic> json)
      : id = json[AbilityFields.id],
        name = json[AbilityFields.name],
        effect = json[AbilityFields.effect],
        generation = json[AbilityFields.generation];

  @override
  Map<String, dynamic> toDB() => {
        AbilityFields.id: id,
        AbilityFields.name: name,
        AbilityFields.effect: effect,
        AbilityFields.generation: generation,
      };

  // Helper Functions
  static String _getEffect(Map<String, dynamic> json) {
    List<dynamic> effects = json["effect_entries"];
    Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
    return slot.first[AbilityFields.effect];
  }

  static int _getGeneration(Map<String, dynamic> json) {
    String url = json[AbilityFields.generation]["url"];
    return url.getId();
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
  CREATE TABLE $abilityModel(
    ${AbilityFields.id} INTEGER PRIMARY KET NOT NULL,
    ${AbilityFields.name} TEXT NOT NULL,
    ${AbilityFields.effect} TEXT NOT NULL,
    ${AbilityFields.generation} INTEGER NOT NULL,
    FOREIGN KEY (${AbilityFields.generation}) REFERENCES $generationModel (id)
  )""";
