import 'dart:typed_data';

import '_model.dart';

import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/types/enums/category.dart';

const String itemModel = "item";

class Item implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  static List<String> getFields() => ItemFields.fields;

  // Strings
  final String name;
  final String effect;
  final String? sprite;

  // Integers
  final int id;
  final int cost;
  final Category category; // Foreign Key to Attribute ENUM

  //----------------------------------------------------------------------------

  // Core Constructor

  Item({
    required this.id,
    required this.cost,
    required this.name,
    required this.effect,
    required this.sprite,
    required this.category,
  });

  Item.filler()
      : id = 0,
        cost = 0,
        name = blank,
        effect = blank,
        sprite = null,
        category = Category.error;

  // JSON Parsing
  @override
  Item.fromAPI(Map<String, dynamic> json)
      : id = json[ItemFields.id] ?? 0,
        cost = json[ItemFields.cost] ?? 0,
        name = json[ItemFields.name] ?? blank,
        effect = _getEffect(json),
        sprite = json[ItemFields.sprite],
        category = _getCategory(json);

  @override
  Item.fromDB(Map<String, dynamic> json)
      : id = json[ItemFields.id] ?? 0,
        cost = json[ItemFields.cost] ?? 0,
        name = json[ItemFields.name] ?? blank,
        effect = json[ItemFields.effect] ?? blank,
        sprite = json[ItemFields.sprite],
        category = Category.values[json[ItemFields.category]];

  @override
  Map<String, dynamic> toDB() => {
        ItemFields.id: id,
        ItemFields.cost: cost,
        ItemFields.name: name,
        ItemFields.effect: effect,
        ItemFields.sprite: sprite,
        ItemFields.category: category.index,
      };

  // Helper Functions
  static Category _getCategory(Map<String, dynamic> json) {
    String url = json[ItemFields.category]["url"] ?? "000";
    return Category.values[url.getId()];
  }

  static String _getEffect(Map<String, dynamic> json) {
    List<dynamic> effects = json["effect_entries"] ?? [];
    String field = ItemFields.effect;

    if (effects.isEmpty) {
      effects = json["flavor_text_entries"];
      field = "text";
    }

    String? effect;
    if (effects.isNotEmpty) {
      Iterable slot = effects.where((slot) => slot["language"]["name"] == "en");
      effect = slot.last[field];
    }

    return effect ?? blank;
  }

  Uint8List? getImage() {
    Uint8List? image;
    if (sprite != null) {
      List<int> data = sprite!.codeUnits;
      image = Uint8List.fromList(data);
    }
    return image;
  }
}

class ItemFields {
  const ItemFields();

  // Strings
  static const String name = "name";
  static const String effect = "effect";
  static const String sprite = "sprite";

  // Integers
  static const String id = "id";
  static const String cost = "cost";
  static const String category = "category";

  static const List<String> fields = [id, name, effect, sprite, cost, category];
}

const String itemMaker = """
  CREATE TABLE IF NOT EXISTS $itemModel(
    ${ItemFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${ItemFields.cost} INTEGER KEY NOT NULL,
    ${ItemFields.name} TEXT NOT NULL,
    ${ItemFields.effect} TEXT NOT NULL,
    ${ItemFields.sprite} TEXT,
    ${ItemFields.category} INTEGER NOT NULL
  )""";
