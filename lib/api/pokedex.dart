import 'dart:convert';
import 'package:http/http.dart';
import 'package:pokedex/api/pokemon.dart';
import 'package:pokedex/prefs/prefs.dart';

class Pokedex {
  // Global Pokedex Class

  // Constants
  static const int tryLimit = 1;
  static const String prefKey = "pokedex";
  static const String link =
      "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0";

  // Variables
  static List<Pokemon> _pokedex = [];
  static List<Pokemon> get pokedex => _pokedex;

  // Constructor
  static Future<List<Pokemon>> init() async {
    List<String>? list = SharedPrefs.getStringList(prefKey);
    if (list != null) {
      _pokedex =
          list.map((json) => Pokemon.fromJson(jsonDecode(json))).toList();
    } else {
      int tries = 0;
      bool success = await update();
      while (!success && tries < tryLimit) {
        success = await update();
        tries++;
      }
      if (!success) throw Error();
    }
    return _pokedex;
  }

  // JSON Converters
  static Future<List<Pokemon>> fromJson(List<String> jsons) async {
    List<Pokemon> pokemons = [];
    await Future.forEach(jsons, (map) async {
      Map<String, dynamic> json = jsonDecode(map);
      Pokemon pokemon = Pokemon.fromJson(json);
      pokemons.add(pokemon);
    });
    return pokemons;
  }

  static List<String> toJson(List<Pokemon> pokemons) {
    List<String> jsons = [];
    for (Pokemon pokemon in pokemons) {
      String jsonString = json.encode(pokemon.toJson());
      jsons.add(jsonString);
    }

    return jsons;
  }

  // Update Functions
  static Future<bool> update() async {
    _pokedex = await apiCall();
    return SharedPrefs.setStringList(prefKey, toJson(_pokedex));
  }

  static Future<List<Pokemon>> apiCall() async {
    Response response = await get(Uri.parse(link));

    if (response.statusCode == 200) {
      try {
        List<dynamic> results = jsonDecode(response.body)["results"];
        List<Pokemon> pokedex = [];

        await Future.forEach(results, (item) async {
          Pokemon pokemon = await Pokemon.fromAPI(item["name"]);
          pokedex.add(pokemon);
        });

        return pokedex;
      } catch (err) {
        throw Exception(err);
      }
    } else {
      throw Error();
    }
  }

  // // Debug
  // static void printAll() {
  //   for (var i in _pokedex) {
  //     print(i.name);
  //   }
  // }
}
