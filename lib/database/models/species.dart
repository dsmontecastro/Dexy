import '_model.dart';
import 'evolution.dart';

import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/types/enums/generation.dart';

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
  bool caught;
  bool favorite;
  final bool isBaby;
  final bool isMythical;
  final bool isLegendary;
  final bool hasAlter;
  final bool hasForms;

  // Integers
  final int id;
  final int order;
  final int happiness;
  final int catchRate;
  final int genderRate;
  final Generation generation;

  // Foreign Keys
  final int evolutions;
  final List<int> varieties;

  //----------------------------------------------------------------------------

  // Core Constructor
  Species(
      {required this.name,
      required this.text,
      required this.genus,
      required this.growthRate,
      required this.caught,
      required this.favorite,
      required this.isBaby,
      required this.isMythical,
      required this.isLegendary,
      required this.hasAlter,
      required this.hasForms,
      required this.id,
      required this.order,
      required this.happiness,
      required this.catchRate,
      required this.genderRate,
      required this.generation,
      required this.evolutions,
      required this.varieties});

  Species.filler()
      : name = "_",
        text = "_",
        genus = "_",
        growthRate = "_",
        caught = false,
        favorite = false,
        isBaby = false,
        isMythical = false,
        isLegendary = false,
        hasAlter = false,
        hasForms = false,
        id = 0,
        order = 0,
        happiness = 0,
        catchRate = 0,
        genderRate = 0,
        generation = Generation.error,
        evolutions = 0,
        varieties = [];

  // JSON Parsing

  @override
  Species.fromAPI(Map<String, dynamic> json)
      : name = json[SpeciesFields.name],
        text = _getLang(json, SpeciesFields.texts, SpeciesFields.text),
        genus = _getLang(json, SpeciesFields.genera, SpeciesFields.genus),
        growthRate = json[SpeciesFields.growthRate]["name"],
        caught = json[SpeciesFields.caught],
        favorite = json[SpeciesFields.favorite],
        isBaby = json[SpeciesFields.isBaby],
        isMythical = json[SpeciesFields.isMythical],
        isLegendary = json[SpeciesFields.isLegendary],
        hasAlter = json[SpeciesFields.hasAlter],
        hasForms = json[SpeciesFields.hasForms],
        id = json[SpeciesFields.id],
        order = json["order"] ?? 0, // problematic string in DB
        happiness = json[SpeciesFields.happiness] ?? 0, // Nullable in later Gens
        catchRate = json[SpeciesFields.catchRate],
        genderRate = json[SpeciesFields.genderRate],
        generation = _getGeneration(json),
        evolutions = _getURLid(json, SpeciesFields.evolutions),
        varieties = _getVarieties(json);

  Species.fromDB(Map<String, dynamic> json)
      : name = json[SpeciesFields.name],
        text = json[SpeciesFields.text],
        genus = json[SpeciesFields.genus],
        growthRate = json[SpeciesFields.growthRate],
        caught = json[SpeciesFields.caught] == 1,
        favorite = json[SpeciesFields.favorite] == 1,
        isBaby = json[SpeciesFields.isBaby] == 1,
        isMythical = json[SpeciesFields.isMythical] == 1,
        isLegendary = json[SpeciesFields.isLegendary] == 1,
        hasAlter = json[SpeciesFields.hasAlter] == 1,
        hasForms = json[SpeciesFields.hasForms] == 1,
        id = json[SpeciesFields.id],
        order = json[SpeciesFields.order],
        happiness = json[SpeciesFields.happiness],
        catchRate = json[SpeciesFields.catchRate],
        genderRate = json[SpeciesFields.genderRate],
        generation = Generation.values[json[SpeciesFields.generation]],
        evolutions = json[SpeciesFields.evolutions],
        varieties = (json[SpeciesFields.varieties] as String).toListInt();

  @override
  Map<String, dynamic> toDB() => {
        SpeciesFields.name: name,
        SpeciesFields.text: text,
        SpeciesFields.genus: genus,
        SpeciesFields.growthRate: growthRate,
        SpeciesFields.caught: caught ? 1 : 0,
        SpeciesFields.favorite: favorite ? 1 : 0,
        SpeciesFields.isBaby: isBaby ? 1 : 0,
        SpeciesFields.isMythical: isMythical ? 1 : 0,
        SpeciesFields.isLegendary: isLegendary ? 1 : 0,
        SpeciesFields.hasAlter: hasAlter ? 1 : 0,
        SpeciesFields.hasForms: hasForms ? 1 : 0,
        SpeciesFields.id: id,
        SpeciesFields.order: order,
        SpeciesFields.happiness: happiness,
        SpeciesFields.catchRate: catchRate,
        SpeciesFields.genderRate: genderRate,
        SpeciesFields.generation: generation.index,
        SpeciesFields.evolutions: evolutions,
        SpeciesFields.varieties: varieties.join(",")
      };

  // Helper Functions

  static Generation _getGeneration(Map<String, dynamic> json) {
    String url = json[SpeciesFields.generation]["url"] ?? "000";
    return Generation.values[url.getId()];
  }

  static String _getLang(Map<String, dynamic> json, String field, String subfield) {
    List<dynamic> list = json[field];

    String? text;
    if (list.isNotEmpty) {
      Iterable slot = list.where((slot) => slot["language"]["name"] == "en");
      text = slot.last[subfield];
    }

    return text ?? "_";
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
  static const String name = "name";
  static const String text = "flavor_text";
  static const String genus = "genus";
  static const String growthRate = "growth_rate";

  static const String texts = "flavor_text_entries"; // Not a column
  static const String genera = "genera"; // Not a column

  // Booleans
  static const String caught = "caught";
  static const String favorite = "favorite";
  static const String isBaby = "is_baby";
  static const String isMythical = "is_mythical";
  static const String isLegendary = "is_legendary";
  static const String hasAlter = "has_gender_differences";
  static const String hasForms = "forms_switchable";

  // Integers
  static const String id = "id";
  static const String order = "ordera";
  static const String happiness = "base_happiness";
  static const String catchRate = "capture_rate";
  static const String genderRate = "gender_rate";
  static const String generation = "generation";

  // Foreign Keys
  static const String evolutions = "evolution_chain";
  static const String varieties = "varieties";

  // List of All Fields
  static const List<String> fields = [
    name,
    text,
    genus,
    growthRate,
    caught,
    favorite,
    isBaby,
    isMythical,
    isLegendary,
    hasAlter,
    hasForms,
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
  CREATE TABLE IF NOT EXISTS $speciesModel(
    ${SpeciesFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${SpeciesFields.name} TEXT NOT NULL,
    ${SpeciesFields.text} TEXT NOT NULL,
    ${SpeciesFields.genus} TEXT NOT NULL,
    ${SpeciesFields.growthRate} TEXT NOT NULL,
    ${SpeciesFields.caught} INTEGER NOT NULL DEFAULT 0,
    ${SpeciesFields.favorite} INTEGER NOT NULL DEFAULT 0,
    ${SpeciesFields.isBaby} INTEGER NOT NULL,
    ${SpeciesFields.isMythical} INTEGER NOT NULL,
    ${SpeciesFields.isLegendary} INTEGER NOT NULL,
    ${SpeciesFields.hasAlter} INTEGER NOT NULL,
    ${SpeciesFields.hasForms} INTEGER NOT NULL,
    ${SpeciesFields.order} INTEGER NOT NULL,
    ${SpeciesFields.happiness} INTEGER NOT NULL,
    ${SpeciesFields.catchRate} INTEGER NOT NULL,
    ${SpeciesFields.genderRate} INTEGER NOT NULL,
    ${SpeciesFields.generation} INTEGER NOT NULL,
    ${SpeciesFields.evolutions} INTEGER NOT NULL,
    ${SpeciesFields.varieties} TEXT NOT NULL,
    FOREIGN KEY (${SpeciesFields.evolutions}) REFERENCES $evolutionModel (id)
  )""";
