import 'dart:developer';
import 'package:flutter/material.dart';

import 'db.dart';
import 'api.dart';

import 'models/evolution.dart';
import 'models/ability.dart';
import 'models/pokemon.dart';
import 'models/species.dart';
import 'models/item.dart';
import 'models/move.dart';

class Dex with ChangeNotifier {
  //

  static const int _displays = 10;
  int get displays => _displays;

  final Pokemon fill = Pokemon.filler();

  // Pokedex Elements ----------------------------------------------------------

  int _listIndex = 0;
  int _menuIndex = 0;
  int get listIndex => _listIndex;
  int get menuIndex => _menuIndex;

  Pokemon? _pokemon;
  Pokemon get pokemon => _pokemon ?? fill;

  List<Pokemon> _pokedex = [];
  List<Pokemon> get pokedex => _pokedex;

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
      _listIndex = 0;
      _menuIndex = 0;
      _pokedex = _pokemons;
      _pokemon = _pokedex[0];
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

  int count() => _pokedex.length;

  Pokemon get(int index) {
    Pokemon? pokemon;
    if (index >= 0 && index < _pokedex.length) {
      pokemon = _pokedex[index];
    }
    return pokemon ?? fill;
  }

  void filter(String filter) {
    _pokedex = _pokemons.where((p) => p.name.startsWith(filter)).toList();
    cycleList(0);
  }

  void cycleList(int index) async {
    int max = count();
    _listIndex = index;

    if (listIndex < 0) {
      _listIndex = 0;
    } else if (listIndex >= max) {
      _listIndex = max - 1;
    }

    _pokemon = _pokedex[_listIndex + menuIndex];
    notifyListeners();
  }

  void cycleMenu(int index) async {
    _menuIndex = index;

    if (menuIndex < 0) {
      _menuIndex = 0;
    } else if (menuIndex >= displays) {
      _menuIndex = displays - 1;
    }

    _pokemon = _pokedex[_menuIndex];
    notifyListeners();
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
