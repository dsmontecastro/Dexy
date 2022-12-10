import '_model.dart';

const String damageClassModel = "move-damage-class";

class DamageClass implements Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  final int id;
  final String description;
  // image

  //----------------------------------------------------------------------------

  // Core Constructor
  DamageClass({required this.id, required this.description});

  // JSON Parsing
  @override
  DamageClass.fromAPI(Map<String, dynamic> json)
      : id = json[DamageClassFields.id],
        description = _getDescription(json);

  @override
  DamageClass.fromDB(Map<String, dynamic> json)
      : id = json[DamageClassFields.id],
        description = json[DamageClassFields.description];

  @override
  Map<String, dynamic> toDB() => {
        DamageClassFields.id: id,
        DamageClassFields.description: description,
      };

  // Helper Functions
  static String _getDescription(Map<String, dynamic> json) {
    List<Map> descriptions = json["descriptions"];
    Iterable slot = descriptions.where((slot) => slot["language"]["name"] == "en");
    return slot.first[DamageClassFields.description];
  }
}

class DamageClassFields {
  const DamageClassFields();

  static const String id = "id";
  static const String description = "description";

  static const List<String> fields = [id, description];
}

const String damageClassMaker = """
  CREATE TABLE $damageClassModel(
    ${DamageClassFields.id} INTEGER PRIMARY KET NOT NULL,
    ${DamageClassFields.description} TEXT NOT NULL
  )""";
