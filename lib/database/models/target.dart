import '_model.dart';

const String targetModel = "target";

class Target extends Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => TargetFields.fields;

  final int id;
  final String description;
  // image

  //----------------------------------------------------------------------------

  // Core Constructor
  Target({required this.id, required this.description});

  // JSON Parsing
  Target.make(Map<String, dynamic> json)
      : id = json[TargetFields.id],
        description = json[TargetFields.description];

  @override
  Target fromDB(Map<String, dynamic> json) => Target.make(json);

  @override
  Target fromAPI(Map<String, dynamic> json) {
    // Re-map some Fields & Keys
    json[TargetFields.description] = _getDescription(json);
    return Target.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        TargetFields.id: id,
        TargetFields.description: description,
      };

  // Helper Functions
  String _getDescription(Map<String, dynamic> json) {
    List<Map> descriptions = json["descriptions"];
    Iterable slot = descriptions.where((slot) => slot["language"]["name"] == "en");
    return slot.first[TargetFields.description];
  }
}

class TargetFields {
  static const List<String> fields = [id, description];

  static const String id = "id";
  static const String description = "description";
}
