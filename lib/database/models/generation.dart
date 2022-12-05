import '_model.dart';

import 'package:pokedex/database/models/species.dart';

const String generationModel = "generation";

class Generation implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => GenerationFields.fields;

  final int id;
  final String name;
  final String region;

  //----------------------------------------------------------------------------

  // Core Constructor
  Generation({
    required this.id,
    required this.name,
    required this.region,
  });

  // JSON Parsing
  Generation.make(Map<String, dynamic> json)
      : id = json[GenerationFields.id],
        name = json[GenerationFields.name],
        region = json[GenerationFields.region];

  @override
  Generation fromDB(Map<String, dynamic> json) => Generation.make(json);

  @override
  Generation fromAPI(Map<String, dynamic> json) {
    json[GenerationFields.region] = _getRegion(json);
    return Generation.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        GenerationFields.id: id,
        GenerationFields.name: name,
        GenerationFields.region: region,
      };

  // Helper Functions
  String _getRegion(Map<String, dynamic> json) =>
      json[GenerationFields.region]["name"] as String;
}

class GenerationFields {
  //

  static const List<String> fields = [id, name, region];

  // Properties
  static const String id = "id";
  static const String name = "name";
  static const String region = "main_region";
}
