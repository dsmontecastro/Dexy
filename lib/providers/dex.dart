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

  List<Species> _pokedex = [];
  List<Species> get pokedex => _pokedex;

  Species? _entry;
  Species get entry => _entry ?? Species.filler();

  int _dexIndex = 0;
  int get dexIndex => _dexIndex;
  int get dexCount => _pokedex.length;

  List<Pokemon> _forms = [Pokemon.filler()];
  List<Pokemon> get forms => _forms;

  Pokemon? _form;
  Pokemon get form => _form ?? Pokemon.filler();

  int _formIndex = 0;
  int get formIndex => _formIndex;
  int get formCount => forms.length;

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
      scroll(0); // Will Notify
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

  // Pokedex Content Manipulation ----------------------------------------------

  void filter(String name) {
    _dexIndex = 0;
    _pokedex = _species.where((s) => s.name.contains(name.toLowerCase())).toList();
    notifyListeners();
  }

  void scroll(int i) {
    if (dexIndex.inRange(0, dexCount)) {
      // Change current Pokedex Entry
      _entry = _pokedex[i];
      _dexIndex = i;

      // Change current Entry's Form
      _forms = entry.varieties.map((id) => getPokemon(id)).toList();
      _form = forms[0];
      _formIndex = 0;

      notifyListeners();
    }
  }

  void changeForm(int i) {
    if (i != _formIndex && i.inRange(0, formCount)) {
      _formIndex = i;
      _form = forms[i];
      notifyListeners();
    }
  }

  void nextForm() => changeForm(_formIndex + 1);
  void prevForm() => changeForm(_formIndex - 1);

  // Specific Resource Getters -------------------------------------------------

  Species getSpecies(int i) {
    Species? species;
    if (i.inRange(0, dexCount)) species = _pokedex[i];
    return species ?? Species.filler();
  }

  Pokemon getPokemon(int? i) {
    Pokemon? pokemon;
    Iterable slot = _pokemons.where((p) => p.id == i);
    if (slot.isNotEmpty) pokemon = slot.first;
    return pokemon ?? Pokemon.filler();
  }

  // Alter User-Toggled States -------------------------------------------------

  Future<bool> favorite(Species s) async {
    try {
      await DB.instance.toggleFavorite(s);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> caught(Species s) async {
    try {
      await DB.instance.toggleCaught(s);
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
