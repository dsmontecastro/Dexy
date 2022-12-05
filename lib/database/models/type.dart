import '_model.dart';

import 'package:pokedex/extensions/string.dart';

const String typeModel = "type";

class Type implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => TypeFields.fields;

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
  Type(
      {required this.id,
      required this.name,
      required this.noTo,
      required this.noFrom,
      required this.halfTo,
      required this.halfFrom,
      required this.doubleTo,
      required this.doubleFrom});

  // JSON Parsing
  Type.make(Map<String, dynamic> json)
      : id = json[TypeFields.id],
        name = json[TypeFields.name],
        noTo = json[TypeFields.noTo],
        noFrom = json[TypeFields.noFrom],
        halfTo = json[TypeFields.halfTo],
        halfFrom = json[TypeFields.halfFrom],
        doubleTo = json[TypeFields.doubleTo],
        doubleFrom = json[TypeFields.doubleFrom];

  @override
  Type fromDB(Map<String, dynamic> json) {
    json[TypeFields.noTo] = (json[TypeFields.noTo] as String).toListInt();
    json[TypeFields.noFrom] = (json[TypeFields.noFrom] as String).toListInt();
    json[TypeFields.halfTo] = (json[TypeFields.halfTo] as String).toListInt();
    json[TypeFields.halfFrom] = (json[TypeFields.halfFrom] as String).toListInt();
    json[TypeFields.doubleTo] = (json[TypeFields.doubleTo] as String).toListInt();
    json[TypeFields.doubleFrom] = (json[TypeFields.doubleFrom] as String).toListInt();
    return Type.make(json);
  }

  @override
  Type fromAPI(Map<String, dynamic> json) {
    // Re-map some Fields & Keys
    json[TypeFields.noTo] = _getRelation(json, TypeFields.noTo);
    json[TypeFields.noFrom] = _getRelation(json, TypeFields.noFrom);
    json[TypeFields.halfTo] = _getRelation(json, TypeFields.halfTo);
    json[TypeFields.halfFrom] = _getRelation(json, TypeFields.halfFrom);
    json[TypeFields.doubleTo] = _getRelation(json, TypeFields.doubleTo);
    json[TypeFields.doubleFrom] = _getRelation(json, TypeFields.doubleFrom);
    return Type.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        TypeFields.id: id,
        TypeFields.name: name,
        TypeFields.noTo: noTo,
        TypeFields.noFrom: noFrom,
        TypeFields.halfTo: halfTo,
        TypeFields.halfFrom: halfFrom,
        TypeFields.doubleTo: doubleTo,
        TypeFields.doubleFrom: doubleFrom
      };

  // Helper Functions
  List<int> _getRelation(Map<String, dynamic> json, String field) {
    List<Map<String, String>> relations = json["damage_relations"][field];
    return relations.map((type) => (type["url"] as String).getId()).toList();
  }
}

class TypeFields {
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
