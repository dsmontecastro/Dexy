import '_model.dart';

const String targetModel = "target";

class Target implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  final int id;
  final String description;
  // image

  //----------------------------------------------------------------------------

  // Core Constructor
  Target({required this.id, required this.description});

  // JSON Parsing
  Target.fromAPI(Map<String, dynamic> json)
      : id = json[TargetFields.id],
        description = _getDescription(json);

  Target.fromDB(Map<String, dynamic> json)
      : id = json[TargetFields.id],
        description = json[TargetFields.description];

  @override
  Map<String, dynamic> toDB() => {
        TargetFields.id: id,
        TargetFields.description: description,
      };

  // Helper Functions
  static String _getDescription(Map<String, dynamic> json) {
    List<Map> descriptions = json["descriptions"];
    Iterable slot = descriptions.where((slot) => slot["language"]["name"] == "en");
    return slot.first[TargetFields.description];
  }
}

class TargetFields {
  const TargetFields();

  static const String id = "id";
  static const String description = "description";

  static const List<String> fields = [id, description];
}

const String targetMaker = """
  CREATE TABLE $targetModel(
    ${TargetFields.id} INTEGER PRIMARY KET NOT NULL,
    ${TargetFields.description} TEXT NOT NULL
  )""";
