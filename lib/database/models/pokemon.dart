import '_model.dart';

const String pokemonTable = "pokemon";

class Pokemon extends Table {
  //----------------------------------------------------------------------------

  @override
  List<String> getFields() => PokemonFields.fields;

  // Non-Integers
  final String name;
  final String icon;
  final String image;
  final bool isDefault;
  bool favorite;

  // Integers
  final int id;
  final int order;
  final int height;
  final int weight;
  final int baseXP;
  final int species;

  // Base Stats
  final int hp;
  final int speed;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;

  // Foreign Keys
  final int type1;
  final int? type2;
  final int ability1;
  final int? ability2;
  final int? abilityH;

  // Multiple Foreign Keys
  final List<int> forms;
  final List<int> heldItems;
  final List<int> gameIndices;
  final List<Map<int, int>> moves;

  //----------------------------------------------------------------------------

  // Core Constructor
  Pokemon(
      {required this.name,
      this.icon = "",
      this.image = "",
      required this.isDefault,
      this.favorite = false,
      required this.id,
      required this.order,
      required this.height,
      required this.weight,
      required this.baseXP,
      required this.species,
      required this.hp,
      required this.speed,
      required this.attack,
      required this.defense,
      required this.specialAttack,
      required this.specialDefense,
      required this.type1,
      this.type2 = 0,
      required this.ability1,
      this.ability2 = 0,
      this.abilityH = 0,
      this.forms = const [],
      this.moves = const [],
      this.heldItems = const [],
      this.gameIndices = const []});

  // JSON Parsing
  @override
  Pokemon fromJson(Map<String, dynamic> json) => Pokemon.fromJson(json);

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json[PokemonFields.name],
        icon = json[PokemonFields.icon],
        image = json[PokemonFields.image],
        isDefault = json[PokemonFields.isDefault],
        favorite = json[PokemonFields.favorite],
        id = json[PokemonFields.id],
        order = json[PokemonFields.order],
        height = json[PokemonFields.height],
        weight = json[PokemonFields.weight],
        baseXP = json[PokemonFields.baseXP],
        species = json[PokemonFields.species],
        hp = json[PokemonFields.hp],
        speed = json[PokemonFields.speed],
        attack = json[PokemonFields.attack],
        defense = json[PokemonFields.defense],
        specialAttack = json[PokemonFields.specialAttack],
        specialDefense = json[PokemonFields.specialDefense],
        type1 = json[PokemonFields.type1],
        type2 = json[PokemonFields.type2],
        ability1 = json[PokemonFields.ability1],
        ability2 = json[PokemonFields.ability2],
        abilityH = json[PokemonFields.abilityH],
        forms = json[PokemonFields.forms],
        moves = json[PokemonFields.moves],
        heldItems = json[PokemonFields.heldItems],
        gameIndices = json[PokemonFields.gameIndices];

  @override
  Map<String, dynamic> toJson() => {
        PokemonFields.name: name,
        PokemonFields.icon: icon,
        PokemonFields.image: image,
        PokemonFields.isDefault: isDefault,
        PokemonFields.favorite: favorite,
        PokemonFields.id: id,
        PokemonFields.order: order,
        PokemonFields.height: height,
        PokemonFields.weight: weight,
        PokemonFields.baseXP: baseXP,
        PokemonFields.species: species,
        PokemonFields.hp: hp,
        PokemonFields.speed: speed,
        PokemonFields.attack: attack,
        PokemonFields.defense: defense,
        PokemonFields.specialAttack: specialAttack,
        PokemonFields.specialDefense: specialDefense,
        PokemonFields.type1: type1,
        PokemonFields.type2: type2,
        PokemonFields.ability1: ability1,
        PokemonFields.ability2: ability2,
        PokemonFields.abilityH: abilityH,
        PokemonFields.forms: forms,
        PokemonFields.moves: moves,
        PokemonFields.heldItems: heldItems,
        PokemonFields.gameIndices: gameIndices
      };
}

class PokemonFields {
  // Field Information

  // None-Integers
  static const String name = "Name";
  static const String icon = "Icon";
  static const String image = "Image";
  static const String isDefault = "Is Default?";
  static const String favorite = "Favorite";

  // Standard Integers
  static const String id = "ID";
  static const String order = "Order";
  static const String height = "Height";
  static const String weight = "Weight";
  static const String baseXP = "Base EXP";
  static const String species = "Species";

  // Base Stats
  static const String hp = "HP";
  static const String speed = "SPD";
  static const String attack = "ATK";
  static const String defense = "DEF";
  static const String specialAttack = "SpA";
  static const String specialDefense = "SpD";

  // Foreign Keys
  static const String type1 = "Primary Type";
  static const String type2 = "Secondary Type";
  static const String ability1 = "Ability 1";
  static const String ability2 = "Ability 2";
  static const String abilityH = "Hidden Ability";

  // Multiple Foreign Keys
  static const String forms = "Forms";
  static const String moves = "Moves";
  static const String heldItems = "Held Items";
  static const String gameIndices = "Game Versions";

  // List of All Fields
  static const List<String> fields = [
    name,
    isDefault,
    favorite,
    id,
    order,
    height,
    weight,
    baseXP,
    species,
    hp,
    speed,
    attack,
    defense,
    specialAttack,
    specialDefense,
    type1,
    type2,
    ability1,
    ability2,
    abilityH,
    forms,
    moves,
    heldItems,
    gameIndices,
  ];
}
