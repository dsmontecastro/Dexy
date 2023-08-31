import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:pokedex/extensions/string.dart';

import 'db.dart';
import 'models/_model.dart';
import 'models/evolution.dart';
import 'models/ability.dart';
import 'models/pokemon.dart';
import 'models/species.dart';
import 'models/item.dart';
import 'models/move.dart';

typedef Result = Map<String, Map<String, String>>;

extension API on DB {
  // API Calls for Updating the DB

  // Constants
  static const int tryLimit = 10;
  static const String list = "limit=100000&offset=";
  static const String head = "https://pokeapi.co/api/v2";

  // API Methods

  Future<bool> updateAll() async {
    List<String> models = Models.models.keys.toList();
    List<String> errors = [];
    bool success = true;

    int i = 0;
    while (i < models.length && success == true) {
      int attempts = 0;
      String model = models[i];

      while (!success && attempts < tryLimit) {
        success = await updateModel(model, 0);
      }

      if (!success) errors.add(model);
      i++;
    }

    log("ERRONEOUS TABLES: $errors");
    return success;
  }

  Future<bool> updateModel(String tableName, int offset) async {
    DB.instance.makeTable(table: tableName);
    List<int> errors = [];
    bool success = true;

    try {
      String type = tableName.replaceAll("_", "-");
      Response resp = await get(Uri.parse("$head/$type?$list$offset"));

      // Validate GET
      if (resp.statusCode == 200) {
        List<dynamic> results = jsonDecode(resp.body)["results"];
        results.cast<Result>();

        await Future.forEach(results, (item) async {
          int attempts = 0;
          bool wasAdded = false;
          String url = item["url"];

          while (!wasAdded && attempts < tryLimit) {
            wasAdded = await updateRow(tableName, url);
          }

          if (!wasAdded) errors.add(url.getId());
          success = wasAdded;
        });
      }

      // Catch Errors
    } catch (err) {
      log(err.toString());
      log("ERRONEOUS ENTRIES: $errors");
      success = false;
    }

    log("TABLE ($tableName): ${success ? "SUCCESS" : "FAILURE"}");
    return success;
  }

  Future<bool> updateRow(String tableName, String url) async {
    bool success = true;

    try {
      Response resp = await get(Uri.parse(url));
      log(url);

      // Validate GET
      if (resp.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(resp.body);

        if (tableName == abilityModel) {
          await upsert<Ability>(tableName, Ability.fromAPI(map));
        } else if (tableName == evolutionModel) {
          await upsert<Evolution>(tableName, Evolution.fromAPI(map));
        } else if (tableName == moveModel) {
          await upsert<Move>(tableName, Move.fromAPI(map));
        } else if (tableName == pokemonModel) {
          await upsert<Pokemon>(tableName, Pokemon.fromAPI(map));
          //

          // ItemModel has Custom Fields
        } else if (tableName == itemModel) {
          String? spriteURL = map["sprites"]["default"];
          String? sprite = await getSprite(spriteURL);
          map[ItemFields.sprite] = sprite;
          await upsert<Item>(tableName, Item.fromAPI(map));
          //

          // SpeciesModel has Custom Fields
        } else if (tableName == speciesModel) {
          Species species = await getById(tableName, map[PokemonFields.id]);
          map[SpeciesFields.favorite] = species.favorite;
          map[SpeciesFields.caught] = species.caught;
          await upsert<Species>(tableName, Species.fromAPI(map));
        }
      }

      // Catch Errors
    } catch (err) {
      log("ID#${url.getId()}: ${err.toString()}");
      success = false;
    }

    return success;
  }

  // used in Item Sprites
  Future<String?> getSprite(String? url) async {
    String? imageString;

    if (url != null) {
      try {
        Response resp = await get(Uri.parse(url));
        if (resp.statusCode == 200) {
          imageString = String.fromCharCodes(resp.bodyBytes);
        }
      } catch (err) {
        log("SPRITE#${url.getId()}: ${err.toString()}");
      }
    }

    return imageString;
  }
}
