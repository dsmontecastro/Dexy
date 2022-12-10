import '_model.dart';

const String generationModel = "generation";

class Generation implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  final int id;
  final String name;
  final String region;

  //----------------------------------------------------------------------------

  // Core Constructor
  Generation({required this.id, required this.name, required this.region});

  // JSON Parsing
  @override
  Generation.fromAPI(Map<String, dynamic> json)
      : id = json[GenerationFields.id],
        name = json[GenerationFields.name],
        region = _getRegion(json);

  @override
  Generation.fromDB(Map<String, dynamic> json)
      : id = json[GenerationFields.id],
        name = json[GenerationFields.name],
        region = json[GenerationFields.region];

  @override
  Map<String, dynamic> toDB() => {
        GenerationFields.id: id,
        GenerationFields.name: name,
        GenerationFields.region: region,
      };

  // Helper Functions
  static String _getRegion(Map<String, dynamic> json) =>
      json[GenerationFields.region]["name"] as String;
}

class GenerationFields {
  const GenerationFields();

  // Properties
  static const String id = "id";
  static const String name = "name";
  static const String region = "main_region";

  static const List<String> fields = [id, name, region];
}

const String generationMaker = """
  CREATE TABLE $generationModel(
    ${GenerationFields.id} INTEGER PRIMARY KET NOT NULL,
    ${GenerationFields.name} TEXT NOT NULL,
    ${GenerationFields.region} TEXT NOT NULL
  )""";
