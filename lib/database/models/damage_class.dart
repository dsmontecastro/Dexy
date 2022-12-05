import '_model.dart';

const String damageClassModel = "move-damage-class";

class DamageClass extends Model {
  //----------------------------------------------------------------------------

  @override
  int getId() => id;

  @override
  List<String> getFields() => DamageClassFields.fields;

  final int id;
  final String description;
  // image

  //----------------------------------------------------------------------------

  // Core Constructor
  DamageClass({required this.id, required this.description});

  // JSON Parsing
  DamageClass.make(Map<String, dynamic> json)
      : id = json[DamageClassFields.id],
        description = json[DamageClassFields.description];

  @override
  DamageClass fromDB(Map<String, dynamic> json) => DamageClass.make(json);

  @override
  DamageClass fromAPI(Map<String, dynamic> json) {
    json[DamageClassFields.description] = _getDescription(json);
    return DamageClass.make(json);
  }

  @override
  Map<String, dynamic> toDB() => {
        DamageClassFields.id: id,
        DamageClassFields.description: description,
      };

  // Helper Functions
  String _getDescription(Map<String, dynamic> json) {
    List<Map> descriptions = json["descriptions"];
    Iterable slot = descriptions.where((slot) => slot["language"]["name"] == "en");
    return slot.first[DamageClassFields.description];
  }
}

class DamageClassFields {
  static const List<String> fields = [id, description];

  static const String id = "id";
  static const String description = "description";
}
