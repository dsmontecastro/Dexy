import 'dart:convert';
import '_model.dart';

const String evolutionModel = "evolution";

class Evolution implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => EvolutionFields.fields;

  final int id;
  final Map<String, dynamic> chain;

  //----------------------------------------------------------------------------

  // Core Constructor
  Evolution({required this.id, required this.chain});

  // JSON Parsing
  Evolution.make(Map<String, dynamic> json)
      : id = json[EvolutionFields.id],
        chain = json[EvolutionFields.chain];

  @override
  Evolution fromDB(Map<String, dynamic> json) {
    // Convert from JSON to String
    json[EvolutionFields.chain] = jsonDecode(json[EvolutionFields.chain]);
    return Evolution.make(json);
  }

  @override
  Evolution fromAPI(Map<String, dynamic> json) => Evolution.make(json);

  @override
  Map<String, dynamic> toDB() =>
      {EvolutionFields.id: id, EvolutionFields.chain: jsonEncode(chain)};
}

class EvolutionFields {
  static const List<String> fields = [id, chain];

  static const String id = "id";
  static const String chain = "chain";
}
