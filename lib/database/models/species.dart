import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String speciesModel = "pokemon-species";

class Species implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => SpeciesFields.fields;

  // Strings
  final String name;
  final String text;
  final String genus;
  final String growthRate;

  // Booleans
  final bool hasAlter;
  final bool hasForms;
  final bool isLegendary;
  final bool isMythical;
  final bool isBaby;

  // Integers
  final int id;
  final int order;
  final int happiness;
  final int catchRate;
  final int genderRate;

  // Foreign Keys
  final int evolutions;
  final int generation;
  final List<int> varieties;

  //----------------------------------------------------------------------------

  // Core Constructor
  Species({
    required this.name,
    required this.text,
    required this.genus,
    required this.growthRate,
    required this.hasAlter,
    required this.hasForms,
    required this.isLegendary,
    required this.isMythical,
    required this.isBaby,
    required this.id,
    required this.order,
    required this.happiness,
    required this.catchRate,
    required this.genderRate,
    required this.evolutions,
    required this.generation,
    required this.varieties,
  });

  // JSON Parsing
  Species.make(Map<String, dynamic> json)
      : name = json[SpeciesFields.name],
        text = json[SpeciesFields.text],
        genus = json[SpeciesFields.genus],
        growthRate = json[SpeciesFields.growthRate],
        hasAlter = json[SpeciesFields.hasAlter],
        hasForms = json[SpeciesFields.hasForms],
        isLegendary = json[SpeciesFields.isLegendary],
        isMythical = json[SpeciesFields.isMythical],
        isBaby = json[SpeciesFields.isBaby],
        id = json[SpeciesFields.id],
        order = json[SpeciesFields.order],
        happiness = json[SpeciesFields.happiness],
        catchRate = json[SpeciesFields.catchRate],
        genderRate = json[SpeciesFields.genderRate],
        evolutions = json[SpeciesFields.evolutions],
        generation = json[SpeciesFields.generation],
        varieties = json[SpeciesFields.varieties];

  @override
  Species fromDB(Map<String, dynamic> json) {
    // Convert from String to List<int>
    json[SpeciesFields.varieties] = (json[SpeciesFields.varieties] as String).toListInt();
    return Species.make(json);
  }

  @override
  Species fromAPI(Map<String, dynamic> json) {
    // Re-map some Fields & Keys

    // Strings
    json[SpeciesFields.text] = _getLang(json, SpeciesFields.texts, SpeciesFields.text);
    json[SpeciesFields.genus] = _getLang(json, SpeciesFields.genera, SpeciesFields.genus);

    // Foreign Keys
    json[SpeciesFields.growthRate] = json[SpeciesFields.growthRate]["name"];
    json[SpeciesFields.evolutions] = _getURLid(json, SpeciesFields.evolutions);
    json[SpeciesFields.generation] = _getURLid(json, SpeciesFields.generation);

    // List of Foreign Keys: Varieties
    json[SpeciesFields.varieties] = _getVarieties(json);

    return Species.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        SpeciesFields.name: name,
        SpeciesFields.text: text,
        SpeciesFields.genus: genus,
        SpeciesFields.growthRate: growthRate,
        SpeciesFields.hasAlter: hasAlter,
        SpeciesFields.hasForms: hasForms,
        SpeciesFields.isLegendary: isLegendary,
        SpeciesFields.isMythical: isMythical,
        SpeciesFields.isBaby: isBaby,
        SpeciesFields.id: id,
        SpeciesFields.order: order,
        SpeciesFields.happiness: happiness,
        SpeciesFields.catchRate: catchRate,
        SpeciesFields.genderRate: genderRate,
        SpeciesFields.evolutions: evolutions,
        SpeciesFields.generation: generation,
        SpeciesFields.varieties: varieties.join(separator)
      };

  // Helper Functions
  String _getLang(Map<String, dynamic> json, String field, String subfield) {
    List<Map> types = json["types"];
    Iterable slot = types.where((slot) => slot["language"]["name"] == "en");
    return slot.first[field];
  }

  int _getURLid(Map<String, dynamic> json, String field) {
    String url = json[field]["url"];
    return url.getId();
  }

  List<int> _getVarieties(Map<String, dynamic> json) {
    List<int> varieties = [];

    for (final pokemon in json[SpeciesFields.varieties]) {
      String url = pokemon["pokemon"]["url"];
      varieties.add(url.getId());
    }

    return varieties;
  }
}

class SpeciesFields {
  // Field Information

  // Strings
  static const name = "name";
  static const text = "flavor_text";
  static const genus = "genus";
  static const growthRate = "growth_rate";

  static const texts = "flavor_text_entries"; // Not a column
  static const genera = "genera"; // Not a column

  // Booleans
  static const hasAlter = "has_gender_differences";
  static const hasForms = "form_switchable";
  static const isLegendary = "is_legendary";
  static const isMythical = "is_mythical";
  static const isBaby = "is_baby";

  // Integers
  static const id = "id";
  static const order = "order";
  static const happiness = "base_happiness";
  static const catchRate = "capture_rate";
  static const genderRate = "gender_rate";

  // Foreign Keys
  static const evolutions = "Evolutions";
  static const generation = "Generation";
  static const varieties = "Varieties";

  // List of All Fields
  static const List<String> fields = [
    name,
    text,
    genus,
    growthRate,
    hasAlter,
    hasForms,
    isLegendary,
    isMythical,
    isBaby,
    id,
    order,
    happiness,
    catchRate,
    genderRate,
    evolutions,
    generation,
    varieties
  ];
}
