import 'package:flutter/material.dart';

import '../db.dart';
import '../api.dart';

// Models
import '../models/ability.dart';
import '../models/damage_class.dart';
import '../models/evolution.dart';
import '../models/generation.dart';
import '../models/move.dart';
import '../models/pkmn_type.dart';
import '../models/pokemon.dart';
import '../models/species.dart';
import '../models/target.dart';

class Pokedex with ChangeNotifier {
  //

  // Main Pokedex
  int _id = 0;
  late Pokemon _pokemonItem;
  late Species _pokedexItem;
  List<Pokemon> _pokemon = [];
  List<Species> _pokedex = [];

  // Resources
  List<Move> _moves = [];
  List<PkmnType> _types = [];
  List<Target> _targets = [];
  List<Ability> _abilities = [];
  List<DamageClass> _dmgClasses = [];
  List<Evolution> _evolutions = [];
  List<Generation> _generations = [];

  // Getters
  int get id => _id;
  int get count => pokedex.length;
  List<Pokemon> get pokemon => _pokemon;
  List<Species> get pokedex => _pokedex;
  List<Move> get moves => _moves;
  List<PkmnType> get types => _types;
  List<Target> get targets => _targets;
  List<Ability> get abilities => _abilities;
  List<DamageClass> get dmgClasses => _dmgClasses;
  List<Evolution> get evolutions => _evolutions;
  List<Generation> get generations => _generations;

  // API Status
  bool _loaded = false;
  bool get isLoaded => _loaded;

  Future<String> callAPI() async {
    String success = "Success!";

    if (!_loaded) {
      bool flag = await DB.instance.updateAll();
      if (flag) {
        _loaded = true;
        success = await fillPokedex();
        success = await fillResources();
      }
    }

    return success;
  }

  // Initialize Fields
  Future<String> fillPokedex() async {
    String result = "Success!";

    try {
      _id = 0;
      _pokemon = await DB.instance.getAll(pokemonModel) as List<Pokemon>;
      _pokedex = await DB.instance.getAll(speciesModel) as List<Species>;
      notifyListeners();
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

  Future<String> fillResources() async {
    String result = "Success!";

    try {
      _moves = await DB.instance.getAll(moveModel) as List<Move>;
      _types = await DB.instance.getAll(pkmnTypeModel) as List<PkmnType>;
      _targets = await DB.instance.getAll(targetModel) as List<Target>;
      _abilities = await DB.instance.getAll(abilityModel) as List<Ability>;
      _dmgClasses = await DB.instance.getAll(damageClassModel) as List<DamageClass>;
      _evolutions = await DB.instance.getAll(evolutionModel) as List<Evolution>;
      _generations = await DB.instance.getAll(generationModel) as List<Generation>;
      notifyListeners();
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

  // Change Current Items & Lists
  Future<String> changeId(int id) async {
    String result = "Success!";

    try {
      _id = id;
      _pokemonItem = await DB.instance.getById(pokemonModel, _id);
      _pokedexItem = await DB.instance.getById(speciesModel, _id);
      notifyListeners();
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

  Future<String> changeFiltered(String filter) async {
    try {
      _pokemon = await DB.instance.getAll(pokemonModel) as List<Pokemon>;
      _pokedex = await DB.instance.getAll(speciesModel) as List<Species>;
    } catch (err) {
      return err.toString();
    }

    return await changeId(0);
  }

  // User-Toggled States
  Future<String> toggleFavorite(Pokemon pokemon) async {
    try {
      await DB.instance.toggleFavorite(pokemon);
    } catch (err) {
      return err.toString();
    }

    return await changeId(id);
  }

  Future<String> toggleCaught(Pokemon pokemon) async {
    try {
      await DB.instance.toggleCaught(pokemon);
    } catch (err) {
      return err.toString();
    }

    return await changeId(id);
  }
}
