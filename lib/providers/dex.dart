import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pokedex/extensions/num.dart';

import '../database/db.dart';
import '../database/api.dart';

import '../database/models/evolution.dart';
import '../database/models/ability.dart';
import '../database/models/pokemon.dart';
import '../database/models/species.dart';
import '../database/models/item.dart';
import '../database/models/move.dart';

class Dex with ChangeNotifier {
  //

  static const int menuCount = 10;

  // Pokedex Elements ----------------------------------------------------------

  Species? _curr;
  Species get curr => _curr ?? Species.filler();

  List<Species> _pokedex = [];
  List<Species> get pokedex => _pokedex;

  int _index = 0;
  int get index => _index;
  int get count => _pokedex.length;

  // Resources -----------------------------------------------------------------
  List<Item> _items = [];
  List<Move> _moves = [];
  List<Species> _species = [];
  List<Pokemon> _pokemons = [];
  List<Ability> _abilities = [];
  List<Evolution> _evolutions = [];

  List<Item> get items => _items;
  List<Move> get moves => _moves;
  List<Species> get species => _species;
  List<Pokemon> get pokemons => _pokemons;
  List<Ability> get abilities => _abilities;
  List<Evolution> get evolutions => _evolutions;

  // Initializers --------------------------------------------------------------

  Dex() {
    _init();
  }

  Future<bool> _init() async {
    DB.instance.makeTable();
    bool success = false;
    success = await _fillResources();
    success = await _fillPokedex();
    return success;
  }

  Future<bool> _fillPokedex() async {
    bool result = true;

    try {
      _pokedex = _species.where((p) => p.id != 0).toList();
      _curr = _pokedex[0];
      _index = 0;
      notifyListeners();
    } catch (err) {
      result = false;
    }

    return result;
  }

  Future<bool> _fillResources() async {
    bool result = true;

    try {
      _evolutions = await DB.instance.getAll<Evolution>(evolutionModel);
      _abilities = await DB.instance.getAll<Ability>(abilityModel);
      _pokemons = await DB.instance.getAll<Pokemon>(pokemonModel);
      _species = await DB.instance.getAll<Species>(speciesModel);
      _items = await DB.instance.getAll<Item>(itemModel);
      _moves = await DB.instance.getAll<Move>(moveModel);
      notifyListeners();
    } catch (err) {
      log("! ERROR: $err");
      result = false;
    }

    return result;
  }

  // API Status ----------------------------------------------------------------

  Future<bool> callAPI({String table = "", int offset = 0}) async {
    bool success = false;

    if (table == "") {
      success = await DB.instance.updateAll();
    } else {
      success = await DB.instance.updateModel(table, offset);
    }

    if (success) success = await _init();

    return success;
  }

  // Alter Dex & Resources -----------------------------------------------------

  Species getSpecies(int i) {
    Species? species;
    if (i.inRange(0, count)) species = _pokedex[i];
    return species ?? Species.filler();
  }

  Pokemon getPokemon(int i) {
    Pokemon? pokemon;
    Iterable slot = _pokemons.where((p) => p.id == i);
    if (slot.isNotEmpty) pokemon = slot.first;
    return pokemon ?? Pokemon.filler();
  }

  void filter(String s) {
    _index = 0;
    _pokedex = _species.where((p) => p.name.startsWith(s)).toList();
    notifyListeners();
  }

  void scroll(int i) {
    if (index.inRange(0, count)) {
      _index = i;
      _curr = _pokedex[i];
      notifyListeners();
    }
  }

  // Alter User-Toggled States -------------------------------------------------

  Future<bool> favorite(Pokemon mon) async {
    try {
      await DB.instance.toggleFavorite(mon);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> caught(Pokemon mon) async {
    try {
      await DB.instance.toggleCaught(mon);
      return true;
    } catch (err) {
      return false;
    }
  }

  // [TEMP] Debugging ----------------------------------------------------------

  Future<void> close() async => await DB.instance.close();

  Future<void> make(String table) async {
    await DB.instance.makeTable(table: table);
  }

  Future<void> drop(String table) async {
    await DB.instance.dropTable(table);
    log("! DROPPED $table");
  }

  Future<void> clear(String table) async {
    await DB.instance.clearTable(table);
    log("! CLEARED $table");
  }
}
