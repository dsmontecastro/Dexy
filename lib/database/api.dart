import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'db.dart';
import 'models/_model.dart';
import 'models/ability.dart';
import 'models/damage_class.dart';
import 'models/evolution.dart';
import 'models/generation.dart';
import 'models/pkmn_type.dart';
import 'models/move.dart';
import 'models/pokemon.dart';
import 'models/species.dart';
import 'models/target.dart';

typedef Result = Map<String, Map<String, String>>;

extension API on DB {
  // API Calls for Updating the DB

  // Constants
  static const int tryLimit = 100;
  static const String list = "limit=100000&offset=0";
  static const String head = "https://pokeapi.co/api/v2";

  // API Methods
  Future<bool> updateAll() async {
    bool success = true;
    List<String> models = Models.models.keys.toList();

    int i = 0;
    while (i < models.length && success == true) {
      print(i);
      success = success && await updateModel(models[i]);
      if (success) i++;
    }

    return success;
  }

  Future<bool> updateModel(String tableName) async {
    bool success = true;
    print(tableName);

    try {
      Response resp = await get(Uri.parse("$head/$tableName?$list"));

      // Validate GET
      if (resp.statusCode == 200) {
        List<dynamic> results = jsonDecode(resp.body)["results"];
        results.cast<Result>();

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
      success = false;
    }

    return success;
  }

  Future<bool> updateRow(String tableName, String url) async {
    bool success = false;
    print("> $url");

    try {
      Response resp = await get(Uri.parse(url));

      // Validate GET
      if (resp.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(resp.body);
        // maps.cast<List<Map<String, dynamic>>>();
        print("> ID: ${map["id"]}");

        if (tableName == abilityModel) {
          await upsert<Ability>(tableName, Ability.fromAPI(map));
        } else if (tableName == damageClassModel) {
          await upsert<DamageClass>(tableName, DamageClass.fromAPI(map));
        } else if (tableName == evolutionModel) {
          await upsert<Evolution>(tableName, Evolution.fromAPI(map));
        } else if (tableName == generationModel) {
          await upsert<Generation>(tableName, Generation.fromAPI(map));
        } else if (tableName == generationModel) {
          await upsert<Move>(tableName, Move.fromAPI(map));
        } else if (tableName == moveModel) {
          await upsert<PkmnType>(tableName, PkmnType.fromAPI(map));
        } else if (tableName == pkmnTypeModel) {
          await upsert<Species>(tableName, Species.fromAPI(map));
        } else if (tableName == speciesModel) {
          await upsert<Target>(tableName, Target.fromAPI(map));
        } else if (tableName == pokemonModel) {
          // Pokemon Model has special columns

          // Save User-Toggled Fields
          Pokemon pokemon = await getById(tableName, map[PokemonFields.id]);
          map[PokemonFields.favorite] = pokemon.favorite;
          map[PokemonFields.caught] = pokemon.caught;

          // Get & Convert Sprites
          String iconURL = map["sprites"]["versions"]["generation-viii"]["front_default"];
          String imageURL = map["sprites"]["other"]["official-artwork"]["front_default"];
          map[PokemonFields.icon] = await updateSprite(iconURL);
          map[PokemonFields.image] = await updateSprite(imageURL);

          await upsert<Pokemon>(tableName, Pokemon.fromAPI(map));
        }
      }

      // Catch Errors
    } catch (err) {
      log(err.toString());
      success = false;
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

  // Helper Functions
  List<Result> getResults(Response resp) {
    List<dynamic> jsons = jsonDecode(resp.body);
    List<Result> results = [];

    for (int i = 0; i < jsons.length; i++) {
      Map json = jsons[i];
      json.map((key, value) => MapEntry(key as String, value as Map<String, String>));
      results.add(json as Result);
    }

    return results;
  }
}
