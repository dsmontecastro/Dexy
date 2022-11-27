import 'dart:convert';
import 'package:http/http.dart';

const String link = "https://pokeapi.co/api/v2/pokemon";

class Pokemon {
  // Private Fields
  final int _id;
  final String _name;
  final String _icon;

  // Getters
  int get id => _id;
  String get name => _name;
  String get icon => _icon;

  // Constructors
  Pokemon._create(int? id, String? name, String? icon)
      : _id = id ?? -1,
        _name = name ?? "",
        _icon = icon ?? "";

  static Future<Pokemon> fromAPI(String name) async {
    Response response = await get(Uri.parse("$link/$name"));
    // print("Creating $name...");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> result = jsonDecode(response.body);
        // print("pokemon found");
        // print(result["id"]);
        // print(result["name"]);
        // print(result["sprites"]["front_default"]);
        Pokemon temp =
            Pokemon._create(result["id"], result["name"], result["sprites"]["front_default"]);
        // print("pokemon made");
        return temp;
        // return Pokemon._create(results["id"], results["name"], results["icon"]);
      } catch (err) {
        throw Exception("Error: $err");
      }
    } else {
      throw Error();
    }
  }

  Pokemon.fromJson(Map<String, dynamic> info)
      : _id = info["id"],
        _name = info["name"],
        _icon = info["icon"];

  Map<String, dynamic> toJson() => {"id": id, "name": name, "icon": icon};
}
