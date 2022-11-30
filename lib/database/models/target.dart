import '_model.dart';

const String targetsTable = "target";

class Target extends Table {
  //----------------------------------------------------------------------------

  @override
  List<String> getFields() => TargetFields.fields;

  final int id;
  final String effect;

  //----------------------------------------------------------------------------

  // Core Constructor
  Target({required this.id, required this.effect});

  // JSON Parsing
  @override
  Target fromJson(Map<String, dynamic> json) => Target.fromJson(json);

  Target.fromJson(Map<String, dynamic> json)
      : id = json[TargetFields.id],
        effect = json[TargetFields.effect];

  @override
  Map<String, dynamic> toJson() => {
        TargetFields.id: id,
        TargetFields.effect: effect,
      };
}

class TargetFields {
  static const List<String> fields = [id, effect];

  static const String id = "ID";
  static const String effect = "Effect";
}
