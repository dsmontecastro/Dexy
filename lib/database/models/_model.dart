abstract class Table {
  // Abstract Model

  // List of Fields
  List<String> getFields() => [];

  // Core Constructor
  Table();

  // JSON Parsing
  Map<String, dynamic> toJson();
  dynamic fromJson(Map<String, dynamic> json);
}
