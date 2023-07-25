import '_model.dart';
import 'evolution.dart';
import 'generation.dart';

import 'package:pokedex/extensions/string.dart';

const String speciesModel = "pokemon_species";

class Species implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

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
  Species(
      {required this.name,
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
      required this.varieties});

  // JSON Parsing

  @override
  Species.fromAPI(Map<String, dynamic> json)
      : name = json[SpeciesFields.name],
        text = _getLang(json, SpeciesFields.texts, SpeciesFields.text),
        genus = _getLang(json, SpeciesFields.genera, SpeciesFields.genus),
        growthRate = json[SpeciesFields.growthRate]["name"],
        hasAlter = json[SpeciesFields.hasAlter],
        hasForms = json[SpeciesFields.hasForms],
        isLegendary = json[SpeciesFields.isLegendary],
        isMythical = json[SpeciesFields.isMythical],
        isBaby = json[SpeciesFields.isBaby],
        id = json[SpeciesFields.id],
        order = json["order"], // problematic string in DB
        happiness = json[SpeciesFields.happiness],
        catchRate = json[SpeciesFields.catchRate],
        genderRate = json[SpeciesFields.genderRate],
        evolutions = _getURLid(json, SpeciesFields.evolutions),
        generation = _getURLid(json, SpeciesFields.generation),
        varieties = _getVarieties(json);

  @override
  Species.fromDB(Map<String, dynamic> json)
      : name = json[SpeciesFields.name],
        text = json[SpeciesFields.text],
        genus = json[SpeciesFields.genus],
        growthRate = json[SpeciesFields.growthRate],
        hasAlter = json[SpeciesFields.hasAlter] == 1,
        hasForms = json[SpeciesFields.hasForms] == 1,
        isLegendary = json[SpeciesFields.isLegendary] == 1,
        isMythical = json[SpeciesFields.isMythical] == 1,
        isBaby = json[SpeciesFields.isBaby] == 1,
        id = json[SpeciesFields.id],
        order = json[SpeciesFields.order],
        happiness = json[SpeciesFields.happiness],
        catchRate = json[SpeciesFields.catchRate],
        genderRate = json[SpeciesFields.genderRate],
        evolutions = json[SpeciesFields.evolutions],
        generation = json[SpeciesFields.generation],
        varieties = (json[SpeciesFields.varieties] as String).toListInt();

  @override
  Map<String, dynamic> toDB() => {
        SpeciesFields.name: name,
        SpeciesFields.text: text,
        SpeciesFields.genus: genus,
        SpeciesFields.growthRate: growthRate,
        SpeciesFields.hasAlter: hasAlter ? 1 : 0,
        SpeciesFields.hasForms: hasForms ? 1 : 0,
        SpeciesFields.isLegendary: isLegendary ? 1 : 0,
        SpeciesFields.isMythical: isMythical ? 1 : 0,
        SpeciesFields.isBaby: isBaby ? 1 : 0,
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
  static String _getLang(
      Map<String, dynamic> json, String field, String subfield) {
    List<dynamic> types = json["types"];
    Iterable slot = types.where((slot) => slot["language"]["name"] == "en");
    return slot.first[field];
  }

  static int _getURLid(Map<String, dynamic> json, String field) {
    String url = json[field]["url"];
    return url.getId();
  }

  static List<int> _getVarieties(Map<String, dynamic> json) {
    List<int> varieties = [];

    for (final pokemon in json[SpeciesFields.varieties]) {
      String url = pokemon["pokemon"]["url"];
      varieties.add(url.getId());
    }

    return varieties;
  }
}

class SpeciesFields {
  const SpeciesFields();

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
  static const order = "ordera";
  static const happiness = "base_happiness";
  static const catchRate = "capture_rate";
  static const genderRate = "gender_rate";

  // Foreign Keys
  static const evolutions = "evolutions";
  static const generation = "generation";
  static const varieties = "varieties";

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

const String speciesMaker = """
  CREATE TABLE $speciesModel(
    ${SpeciesFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${SpeciesFields.name} TEXT NOT NULL,
    ${SpeciesFields.text} TEXT NOT NULL,
    ${SpeciesFields.genus} TEXT NOT NULL,
    ${SpeciesFields.growthRate} TEXT NOT NULL,
    ${SpeciesFields.hasAlter} INTEGER NOT NULL,
    ${SpeciesFields.hasForms} INTEGER NOT NULL,
    ${SpeciesFields.isLegendary} INTEGER NOT NULL,
    ${SpeciesFields.isMythical} INTEGER NOT NULL,
    ${SpeciesFields.isBaby} INTEGER NOT NULL,
    ${SpeciesFields.order} INTEGER NOT NULL,
    ${SpeciesFields.happiness} INTEGER NOT NULL,
    ${SpeciesFields.catchRate} INTEGER NOT NULL,
    ${SpeciesFields.genderRate} INTEGER NOT NULL,
    ${SpeciesFields.evolutions} INTEGER NOT NULL,
    ${SpeciesFields.generation} INTEGER NOT NULL,
    ${SpeciesFields.varieties} INTEGER NOT NULL,
    FOREIGN KEY (${SpeciesFields.evolutions}) REFERENCES $evolutionModel (id),
    FOREIGN KEY (${SpeciesFields.generation}) REFERENCES $generationModel (id)
  )""";
