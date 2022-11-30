import '_model.dart';

const String speciesTable = "pokemon-species";

class Species implements Table {
  //----------------------------------------------------------------------------

  @override
  List<String> getFields() => SpeciesFields.fields;

  // Strings
  final String name;
  final String text;
  final String genus;

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
  final List<int> pokedexNumbers;

  //----------------------------------------------------------------------------

  // Core Constructor
  Species(
      {required this.name,
      required this.text,
      required this.genus,
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
      this.varieties = const [],
      this.pokedexNumbers = const []});

  // JSON Parsing
  @override
  Species fromJson(Map<String, dynamic> json) => Species.fromJson(json);

  Species.fromJson(Map<String, dynamic> json)
      : name = json[SpeciesFields.name],
        text = json[SpeciesFields.text],
        genus = json[SpeciesFields.genus],
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
        varieties = json[SpeciesFields.varieties],
        pokedexNumbers = json[SpeciesFields.pokedexNumbers];

  @override
  Map<String, dynamic> toJson() => {
        SpeciesFields.name: name,
        SpeciesFields.text: text,
        SpeciesFields.genus: genus,
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
        SpeciesFields.varieties: varieties,
        SpeciesFields.pokedexNumbers: pokedexNumbers
      };
}

class SpeciesFields {
  // Field Information

  // Strings
  static const name = "Name";
  static const text = "Text";
  static const genus = "Genus";

  // Booleans
  static const hasAlter = "Alter?";
  static const hasForms = "Forms?";
  static const isLegendary = "Legendary?";
  static const isMythical = "Mythical?";
  static const isBaby = "Baby?";

  // Integers
  static const id = "ID";
  static const order = "Order";
  static const happiness = "Happiness";
  static const catchRate = "Catch Rate";
  static const genderRate = "Gender Rate";

  // Foreign Keys
  static const evolutions = "Evolutions";
  static const generation = "Generation";
  static const varieties = "Varieties";
  static const pokedexNumbers = "Pokedex Numbers";

  // List of All Fields
  static const List<String> fields = [
    name,
    text,
    genus,
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
    varieties,
    pokedexNumbers
  ];
}
