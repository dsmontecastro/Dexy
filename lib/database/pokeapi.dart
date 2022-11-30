import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokedex/database/models/sprites.dart';

import 'database.dart';
import 'models/_model.dart';
import 'models/pokemon.dart';

extension PokeAPI on PokedexDB {
  // API Calls for Updating the DB

  // Constants
  static const int tryLimit = 100;
  static const String list = "limit=100000&offset=0";
  static const String head = "https://pokeapi.co/api/v2";

  // // API Methods
  // Future<bool> updateAll() async {
  //   await updateX();
  // }

  Future<bool> updateTable(String tableName) async {
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

    try {
      Response resp = await get(Uri.parse(url));

      // Validate GET
      if (resp.statusCode == 200) {
        List<Map<String, dynamic>> maps = jsonDecode(resp.body);

        await Future.forEach(maps, (map) async {
          final Table table = tables[tableName] as Table;
          await add(tableName, table.fromJson(map));

          if (tableName == pokemonTable) {
            String icon = map["sprites"]["versions"]["generation-viii"]["front_default"];
            String image = map["sprites"]["other"]["official-artwork"]["front_default"];

            map["icon"] = await updateSprite(icon);
            map["image"] = await updateSprite(image);
          }
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
