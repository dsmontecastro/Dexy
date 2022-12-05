abstract class Model {
  // Abstract Model

  // List of Fields
  List<String> getFields() => [];

  // Core Constructor
  Model();
  int getId() => -1;

  // JSON Parsing
  Map<String, dynamic> toDB();
  dynamic fromDB(Map<String, dynamic> json);
  dynamic fromAPI(Map<String, dynamic> json);
}
