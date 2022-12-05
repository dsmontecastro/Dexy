import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String abilityModel = "ability";

class Ability implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => AbilityFields.fields;

  // Strings
  final String name;
  final String effect;

  // Integers
  final int id;
  final int generation; // Foreign Key

  //----------------------------------------------------------------------------

  // Core Constructor
  Ability(
      {required this.id, required this.name, required this.effect, required this.generation});

  // JSON Parsing
  Ability.make(Map<String, dynamic> json)
      : id = json[AbilityFields.id],
        name = json[AbilityFields.name],
        effect = json[AbilityFields.effect],
        generation = json[AbilityFields.generation];

  @override
  Ability fromDB(Map<String, dynamic> json) {
    // Convert from String to List<int>
    json[AbilityFields.pokemon] = (json[AbilityFields.pokemon] as String).toListInt();
    return Ability.make(json);
  }

  @override
  Ability fromAPI(Map<String, dynamic> json) {
    // Re-map some Fields & Keys
    json[AbilityFields.effect] = _getEffect(json);
    json[AbilityFields.generation] = _getGeneration(json);
    return Ability.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        AbilityFields.id: id,
        AbilityFields.name: name,
        AbilityFields.effect: effect,
        AbilityFields.generation: generation,
      };

  // Helper Functions
  String _getEffect(Map<String, dynamic> json) {
    List<Map> effects = json["effect_entries"];
    Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
    return slot.first[AbilityFields.effect];
  }

  int _getGeneration(Map<String, dynamic> json) {
    String url = json[AbilityFields.generation]["url"];
    return url.getId();
  }
}

class AbilityFields {
  static const List<String> fields = [id, name, effect, generation, pokemon];

  // Integers
  static const String id = "id";

  // Strings
  static const String name = "name";
  static const String effect = "short_effect";

  // Foreign Keys
  static const String generation = "generation";
  static const String pokemon = "pokemon";
}
