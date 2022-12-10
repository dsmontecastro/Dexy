import 'dart:convert';
import '_model.dart';

const String evolutionModel = "evolution";

class Evolution implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  final int id;
  final Map<String, dynamic> chain;

  //----------------------------------------------------------------------------

  // Core Constructor
  Evolution({required this.id, required this.chain});

  // JSON Parsing
  @override
  Evolution.fromAPI(Map<String, dynamic> json)
      : id = json[EvolutionFields.id],
        chain = json[EvolutionFields.chain];

  @override
  Evolution.fromDB(Map<String, dynamic> json)
      : id = json[EvolutionFields.id],
        chain = json[EvolutionFields.chain];

  @override
  Map<String, dynamic> toDB() =>
      {EvolutionFields.id: id, EvolutionFields.chain: jsonEncode(chain)};
}

class EvolutionFields {
  const EvolutionFields();

  static const String id = "id";
  static const String chain = "chain";

  static const List<String> fields = [id, chain];
}

const String evolutionMaker = """
  CREATE TABLE $evolutionModel(
    ${EvolutionFields.id} INTEGER PRIMARY KET NOT NULL,
    ${EvolutionFields.chain} TEXT NOT NULL
  )""";
