import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'db.dart';
import 'models/_model.dart';
import 'models/pokemon.dart';

extension API on DB {
  // API Calls for Updating the DB

  // Constants
  static const int tryLimit = 100;
  static const String list = "limit=100000&offset=0";
  static const String head = "https://pokeapi.co/api/v2";

  // // API Methods
  // Future<bool> updateAll() async {
  //   await updateX();
  // }

  Future<bool> updateModel(String tableName) async {
    bool success = true;

    try {
      Response resp = await get(Uri.parse("$head/$tableName?$list"));

      // Validate GET
      if (resp.statusCode == 200) {
        List<Map<String, dynamic>> results = jsonDecode(resp.body)["results"];

        await Future.forEach(results, (item) async {
          int i = 0;
          String url = item["url"];
          bool added = await updateRow(tableName, url);

          while (!added && i < 100) {
            added = await updateRow(tableName, url);
          }

          success = success && added;
        });
      }

      // Catch Errors
    } catch (err) {
      log(err.toString());
    }

    return success;
  }

  Future<bool> updateRow(String tableName, String url) async {
    bool success = false;
    bool isPokemon = tableName == pokemonModel;

    try {
      Response resp = await get(Uri.parse(url));

      // Validate GET
      if (resp.statusCode == 200) {
        List<Map<String, dynamic>> maps = jsonDecode(resp.body);

        await Future.forEach(maps, (map) async {
          final Model table = models[tableName] as Model;

          if (isPokemon) {
            // Pokemon Model has special columns

            // Save Favorite State (User-Toggled)
            Pokemon pokemon = await getById(tableName, map[PokemonFields.id]);
            map[PokemonFields.favorite] = pokemon.favorite;

            // Get & Convert Sprites
            String iconURL = map["sprites"]["versions"]["generation-viii"]["front_default"];
            String imageURL = map["sprites"]["other"]["official-artwork"]["front_default"];
            map[PokemonFields.icon] = await updateSprite(iconURL);
            map[PokemonFields.image] = await updateSprite(imageURL);
          }

          await upsert(tableName, table.fromAPI(map));
        });
      }

      // Catch Errors
    } catch (err) {
      log(err.toString());
    }

    return success;
  }

  Future<String> updateSprite(String url) async {
    String imageString = "";

    try {
      Response resp = await get(Uri.parse(url));
      if (resp.statusCode == 200) {
        imageString = String.fromCharCodes(resp.bodyBytes);
      }
    } catch (err) {
      log(err.toString());
    }

    return imageString;
  }
}
