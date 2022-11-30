import '_model.dart';

const String spriteTable = "sprites";

class Sprite implements Table {
  // Sprite (Image) Class

  @override
  List<String> getFields() => SpriteFields.fields;

  final bool gendered;

  // Primary
  final String? icon;
  final String? official;

  // from Home Page
  final String? homeAlter;
  final String? homeShiny;
  final String? homeDefault;
  final String? homeAlterShiny;

  // Default
  final String? defaultBack;
  final String? defaultFront;
  final String? defaultShinyBack;
  final String? defaultShinyFront;

  // Alter (if present)
  final String? alterBack;
  final String? alterFront;
  final String? alterShinyBack;
  final String? alterShinyFront;

  //----------------------------------------------------------------------------

  // Core Constructor
  Sprite(
      {required this.gendered,
      required this.icon,
      required this.official,
      required this.homeAlter,
      required this.homeShiny,
      required this.homeDefault,
      required this.homeAlterShiny,
      required this.defaultBack,
      required this.defaultFront,
      required this.defaultShinyBack,
      required this.defaultShinyFront,
      required this.alterBack,
      required this.alterFront,
      required this.alterShinyBack,
      required this.alterShinyFront});

  // JSON Parsing
  @override
  Sprite fromJson(Map<String, dynamic> json) => Sprite.fromJson(json);

  Sprite.fromJson(Map<String, dynamic> json)
      : gendered = json[SpriteFields.gendered],
        icon = json[SpriteFields.icon],
        official = json[SpriteFields.official],
        homeAlter = json[SpriteFields.homeAlter],
        homeShiny = json[SpriteFields.homeShiny],
        homeDefault = json[SpriteFields.homeDefault],
        homeAlterShiny = json[SpriteFields.homeAlterShiny],
        defaultBack = json[SpriteFields.defaultBack],
        defaultFront = json[SpriteFields.defaultFront],
        defaultShinyBack = json[SpriteFields.defaultShinyBack],
        defaultShinyFront = json[SpriteFields.defaultShinyFront],
        alterBack = json[SpriteFields.alterBack],
        alterFront = json[SpriteFields.alterFront],
        alterShinyBack = json[SpriteFields.alterShinyBack],
        alterShinyFront = json[SpriteFields.alterShinyFront];

  @override
  Map<String, dynamic> toJson() => {
        SpriteFields.gendered: gendered,
        SpriteFields.icon: icon,
        SpriteFields.official: official,
        SpriteFields.homeAlter: homeAlter,
        SpriteFields.homeShiny: homeShiny,
        SpriteFields.homeDefault: homeDefault,
        SpriteFields.homeAlterShiny: homeAlterShiny,
        SpriteFields.defaultBack: defaultBack,
        SpriteFields.defaultFront: defaultFront,
        SpriteFields.defaultShinyBack: defaultShinyBack,
        SpriteFields.defaultShinyFront: defaultShinyFront,
        SpriteFields.alterBack: alterBack,
        SpriteFields.alterFront: alterFront,
        SpriteFields.alterShinyBack: alterShinyBack,
        SpriteFields.alterShinyFront: alterShinyFront
      };
}

class SpriteFields {
  static const String gendered = "Gendered";
  static const String icon = "Icon";
  static const String official = "Official";

  // from Home Page
  static const String homeAlter = "Home Alter";
  static const String homeShiny = "Home Shiny";
  static const String homeDefault = "Home Default";
  static const String homeAlterShiny = "Home Alter Shiny";

  // Default Art
  static const String defaultBack = "Default Back";
  static const String defaultFront = "Default Front";
  static const String defaultShinyBack = "Default Shiny Back";
  static const String defaultShinyFront = "Default Shiny Front";

  // Alter Art (if present)
  static const String alterBack = "Alter Back";
  static const String alterFront = "Alter Front";
  static const String alterShinyBack = "Alter Shiny Back";
  static const String alterShinyFront = "Alter Shiny Front";

  static const List<String> fields = [
    gendered,
    icon,
    official,
    homeAlter,
    homeShiny,
    homeDefault,
    homeAlterShiny,
    defaultBack,
    defaultFront,
    defaultShinyBack,
    defaultShinyFront,
    alterBack,
    alterFront,
    alterShinyBack,
    alterShinyFront
  ];
}
