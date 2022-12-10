import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String pkmnTypeModel = "type";

class PkmnType implements Model {
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
  PkmnType(
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
  PkmnType.fromAPI(Map<String, dynamic> json)
      : id = json[PkmnTypeFields.id],
        name = json[PkmnTypeFields.name],
        noTo = _getRelation(json, PkmnTypeFields.noTo),
        noFrom = _getRelation(json, PkmnTypeFields.noFrom),
        halfTo = _getRelation(json, PkmnTypeFields.halfTo),
        halfFrom = _getRelation(json, PkmnTypeFields.halfFrom),
        doubleTo = _getRelation(json, PkmnTypeFields.doubleTo),
        doubleFrom = _getRelation(json, PkmnTypeFields.doubleFrom);

  @override
  PkmnType.fromDB(Map<String, dynamic> json)
      : id = json[PkmnTypeFields.id],
        name = json[PkmnTypeFields.name],
        noTo = (json[PkmnTypeFields.noTo] as String).toListInt(),
        noFrom = (json[PkmnTypeFields.noFrom] as String).toListInt(),
        halfTo = (json[PkmnTypeFields.halfTo] as String).toListInt(),
        halfFrom = (json[PkmnTypeFields.halfFrom] as String).toListInt(),
        doubleTo = (json[PkmnTypeFields.doubleTo] as String).toListInt(),
        doubleFrom = (json[PkmnTypeFields.doubleFrom] as String).toListInt();

  @override
  Map<String, dynamic> toDB() => {
        PkmnTypeFields.id: id,
        PkmnTypeFields.name: name,
        PkmnTypeFields.noTo: noTo,
        PkmnTypeFields.noFrom: noFrom,
        PkmnTypeFields.halfTo: halfTo,
        PkmnTypeFields.halfFrom: halfFrom,
        PkmnTypeFields.doubleTo: doubleTo,
        PkmnTypeFields.doubleFrom: doubleFrom
      };

  // Helper Functions
  static List<int> _getRelation(Map<String, dynamic> json, String field) {
    List<Map<String, String>> relations = json["damage_relations"][field];
    return relations.map((type) => (type["url"] as String).getId()).toList();
  }
}

class PkmnTypeFields {
  const PkmnTypeFields();

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

const String pkmnTypeMaker = """
  CREATE TABLE $pkmnTypeModel(
    ${PkmnTypeFields.id} INTEGER PRIMARY KET NOT NULL,
    ${PkmnTypeFields.name} TEXT NOT NULL,
    ${PkmnTypeFields.noTo} TEXT NOT NULL,
    ${PkmnTypeFields.noFrom} TEXT NOT NULL,
    ${PkmnTypeFields.halfTo} TEXT NOT NULL,
    ${PkmnTypeFields.halfFrom} TEXT NOT NULL,
    ${PkmnTypeFields.doubleTo} TEXT NOT NULL,
    ${PkmnTypeFields.doubleFrom} TEXT NOT NULL
  )""";
