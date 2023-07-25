import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String typingModel = "type";

class Typing implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  // Basics
  final int id;
  final String name;

  // Damage Relations
  final List<int> noTo;
  final List<int> noFrom;
  final List<int> halfTo;
  final List<int> halfFrom;
  final List<int> doubleTo;
  final List<int> doubleFrom;

  //----------------------------------------------------------------------------

  // Core Constructor
  Typing(
      {required this.id,
      required this.name,
      required this.noTo,
      required this.noFrom,
      required this.halfTo,
      required this.halfFrom,
      required this.doubleTo,
      required this.doubleFrom});

  // JSON Parsing
  @override
  Typing.fromAPI(Map<String, dynamic> json)
      : id = json[TypingFields.id],
        name = json[TypingFields.name],
        noTo = _getRelation(json, TypingFields.noTo),
        noFrom = _getRelation(json, TypingFields.noFrom),
        halfTo = _getRelation(json, TypingFields.halfTo),
        halfFrom = _getRelation(json, TypingFields.halfFrom),
        doubleTo = _getRelation(json, TypingFields.doubleTo),
        doubleFrom = _getRelation(json, TypingFields.doubleFrom);

  @override
  Typing.fromDB(Map<String, dynamic> json)
      : id = json[TypingFields.id],
        name = json[TypingFields.name],
        noTo = (json[TypingFields.noTo] as String).toListInt(),
        noFrom = (json[TypingFields.noFrom] as String).toListInt(),
        halfTo = (json[TypingFields.halfTo] as String).toListInt(),
        halfFrom = (json[TypingFields.halfFrom] as String).toListInt(),
        doubleTo = (json[TypingFields.doubleTo] as String).toListInt(),
        doubleFrom = (json[TypingFields.doubleFrom] as String).toListInt();

  @override
  Map<String, dynamic> toDB() => {
        TypingFields.id: id,
        TypingFields.name: name,
        TypingFields.noTo: noTo,
        TypingFields.noFrom: noFrom,
        TypingFields.halfTo: halfTo,
        TypingFields.halfFrom: halfFrom,
        TypingFields.doubleTo: doubleTo,
        TypingFields.doubleFrom: doubleFrom
      };

  // Helper Functions
  static List<int> _getRelation(Map<String, dynamic> json, String field) {
    List<Map<String, String>> relations = json["damage_relations"][field];
    return relations.map((type) => (type["url"] as String).getId()).toList();
  }
}

class TypingFields {
  const TypingFields();

  // Basic Properties
  static const String id = "id";
  static const String name = "name";

  // Damage Relations
  static const noTo = "no_damage_to";
  static const noFrom = "no_damage_from";
  static const halfTo = "half_damage_to";
  static const halfFrom = "half_damage_from";
  static const doubleTo = "double_damage_to";
  static const doubleFrom = "double_damage_from";

  static const List<String> fields = [
    id,
    name,
    noTo,
    noFrom,
    halfTo,
    halfFrom,
    doubleTo,
    doubleFrom
  ];
}

const String typingMaker = """
  CREATE TABLE $typingModel(
    ${TypingFields.id} INTEGER PRIMARY KEY NOT NULL,
    ${TypingFields.name} TEXT NOT NULL,
    ${TypingFields.noTo} TEXT NOT NULL,
    ${TypingFields.noFrom} TEXT NOT NULL,
    ${TypingFields.halfTo} TEXT NOT NULL,
    ${TypingFields.halfFrom} TEXT NOT NULL,
    ${TypingFields.doubleTo} TEXT NOT NULL,
    ${TypingFields.doubleFrom} TEXT NOT NULL
  )""";
